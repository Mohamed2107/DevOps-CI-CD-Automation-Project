resource "aws_instance" "web" {
  ami           = var.ami
  instance_type = var.type
  subnet_id     = var.subnet_id
  vpc_security_group_ids =var.security_group
  associate_public_ip_address = var.public_ip
  key_name = var.key
  tags = {
    Name = var.tag
  }
}