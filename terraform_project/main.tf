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
//module "private_rds_subnet" {
  //  source = "./moduals/private_subnet"
    //vpc_id = module.vpc.vpc_id
    //subnet_tag = "rds_subnet1"
    //aws_subnet_cidr = "10.0.4.0/24"
    //zone = "us-east-1a"
  
//}
//module "private_rds_subnet2" {
  //  source = "./moduals/private_subnet"
    //vpc_id = module.vpc.vpc_id
    //subnet_tag = "rds_subnet2"
    //aws_subnet_cidr = "10.0.5.0/24"
    //zone = "us-east-1b"
  
//}
//module "security_group_rds" {
  //  vpc_id = module.vpc.vpc_id
    //source = "./moduals/security_group"
    //port = ["3306"]
    //type = ["tcp"]
    //tag = "rds"
  
//}
//module "RDS"{
  //source = "./moduals/rds"
  //db_name = "mysql"
  //db_password = "mysql"
  //rds_subnet_ids = [module.private_rds_subnet.subnet_id,module.private_rds_subnet2.subnet_id]
  //vpc_security_group = [module.security_group_rds.security_group_id]

//}

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

//module "ec2" {
  //  source = "./moduals/ec2"
    //ami = "ami-0c02fb55956c7d316"
    //subnet_id = module.public_subnet.subnet_id
    //security_group = [module.security_group.security_group_id]
  
//}
//module "eks" {
//    source = "./moduals/eks"
 //   subent1 = module.private_eks_subnet2.subnet_id
   // subnet2 = module.private_eks_subnet.subnet_id
    //max_node = 2
    //min_node = 1
  
//}
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