resource "aws_security_group" "sg" {
  name        = "VPC_medha_sg"
  description = "Allow all traffic"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_value
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]  # Allow traffic from any IP
    }
  }

  # Egress rule block
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to any IP
  }

  # Tags block
  tags = {
    Name        = "VPC_medha_sg"

  }
}
