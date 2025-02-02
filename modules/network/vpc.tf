resource "aws_vpc" "VPC_medha" {
  cidr_block           = var.cidr_block
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "VPC_Medha"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_cidr_block)
  vpc_id                  = aws_vpc.VPC_medha.id
  cidr_block              = element(var.public_cidr_block, count.index)
  availability_zone       = element(var.availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.private_cidr_block)
  vpc_id            = aws_vpc.VPC_medha.id
  cidr_block        = element(var.private_cidr_block, count.index)
  availability_zone = element(var.availability_zone, count.index)


  tags = {
    Name = "private_Subnet_${count.index + 1}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.VPC_medha.id

  tags = {
    Name = "VPC_Medha_IGW"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.VPC_medha.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Public_Route_Table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(var.public_cidr_block)
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id

}

