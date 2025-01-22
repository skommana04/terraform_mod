resource "aws_vpc" "VPC_medha" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = true
  instance_tenancy = "default"
 
  

  tags = {
    Name = "VPC_Medha"
  }
}