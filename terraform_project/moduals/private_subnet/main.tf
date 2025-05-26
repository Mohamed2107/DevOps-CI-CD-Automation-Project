resource "aws_subnet" "mysubnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.aws_subnet_cidr
  availability_zone = var.zone

  tags = {
    Name = var.subnet_tag
  }
}
output "subnet_id" {
  value = aws_subnet.mysubnet.id
  
}
