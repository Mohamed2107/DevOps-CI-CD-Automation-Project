resource "aws_subnet" "mysubnet" {
  vpc_id     = var.vpc_id
  cidr_block = var.aws_subnet_cidr

  tags = {
    Name = "subnet1"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "main"
  }
}
resource "aws_route_table" "example" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "example"
  }
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.example.id
}
output "subnet_id" {
    value = aws_subnet.mysubnet.id
  
}
