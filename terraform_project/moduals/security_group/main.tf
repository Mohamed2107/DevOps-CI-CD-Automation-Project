resource "aws_security_group" "web_sg" {
  name        = "web-security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = var.vpc_id  # Make sure to pass this as a variable
  dynamic "ingress" {
    for_each = zipmap(var.port,var.type)
    
    content {
      from_port   = tonumber(ingress.key)
      to_port     = tonumber(ingress.key)
      protocol    = ingress.value
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.tag
  }
}
output "security_group_id" {
    value = aws_security_group.web_sg.id
  
}