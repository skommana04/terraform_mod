resource "aws_vpc" "VPC_medha" {
  cidr_block       = var.cidr_block
  enable_dns_hostnames = true
  instance_tenancy = "default"
 
    tags = {
    Name = "VPC_Medha"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.public_cidr_block)
  vpc_id     = aws_vpc.VPC_medha.id
  cidr_block = var.public_cidr_block
  availability_zone = element(var.availability_zone, count.index)

#   public_cidr_block = "10.0.1.0/24"
  

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}