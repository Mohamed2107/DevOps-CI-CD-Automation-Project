module "vpc" {
     source = "./moduals/vpc"
      cidr = "10.0.0.0/16"

  
}
module "public_subnet" {
    source = "./moduals/public_subnet"
    vpc_id = module.vpc.vpc_id
  
  
}
module "private_eks_subnet" {
    source = "./moduals/private_subnet"
    vpc_id = module.vpc.vpc_id
    subnet_tag = "eks_subnet1"
    aws_subnet_cidr = "10.0.3.0/24"
    zone = "us-east-1a"
  
}
module "private_eks_subnet2" {
    source = "./moduals/private_subnet"
    vpc_id = module.vpc.vpc_id
    subnet_tag = "eks_subnet2"
    aws_subnet_cidr = "10.0.2.0/24"
    zone = "us-east-1b"
  
}

module "security_group" {
   vpc_id = module.vpc.vpc_id
    source = "./moduals/security_group"
    port = ["80","443","22","8080"]
    type = ["tcp","tcp","tcp","tcp"]
    tag = "new"
   
  
}
data "aws_security_group" "eks" {
  id = "sg-08e20f527f2d68eb5"
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("C:\\Users\\ma214\\Downloads\\id_rsa.pub")
}
module "ec2" {
    source = "./moduals/ec2"
    ami = "ami-084568db4383264d4"
    subnet_id = module.public_subnet.subnet_id
    security_group = [module.security_group.security_group_id]
    key=aws_key_pair.deployer.id
    tag="public1"
  
}
module "ec1" {
    source = "./moduals/ec2"
    ami = "ami-084568db4383264d4"
    subnet_id = module.private_eks_subnet2.subnet_id
    security_group = [data.aws_security_group.eks.id]
  key=aws_key_pair.deployer.id
  tag="private2"
}
module "ec" {
    source = "./moduals/ec2"
    ami = "ami-084568db4383264d4"
    subnet_id = module.private_eks_subnet.subnet_id
    security_group = [data.aws_security_group.eks.id]
  key=aws_key_pair.deployer.id
  tag="private1"
}

resource "aws_lb" "web_alb" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.security_group.security_group_id]
  subnets            = [module.public_subnet.subnet_id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
  }
}
resource "aws_lb_target_group_attachment" "tg_attachment_1" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = module.ec.instance_id  
  port             = 30080                   
}

resource "aws_lb_target_group_attachment" "tg_attachment_2" {
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = module.ec1.instance_id
  port             = 30080
}

resource "aws_lb_listener" "web_http" {
  load_balancer_arn = aws_lb.web_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

data "aws_route53_zone" "main" {
  name         = "opp.com"
  private_zone = false
}

resource "aws_route53_record" "web_dns" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.opp.com"
  type    = "A"

  alias {
    name                   = aws_lb.web_alb.dns_name
    zone_id                = aws_lb.web_alb.zone_id
    evaluate_target_health = true
  }
}
