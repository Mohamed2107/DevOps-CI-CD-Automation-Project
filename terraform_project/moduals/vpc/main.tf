resource "aws_vpc" "myvpc" {
  cidr_block       = var.cidr

  tags = {
    Name = "vpc1"
  }
}
output "vpc_id" {
    value = aws_vpc.myvpc.id
  
}