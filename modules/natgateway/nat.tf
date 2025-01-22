resource "aws_eip" "nat_eip" {
  count  = length(var.public_cidr_block)
  domain = "vpc"
  tags = {
    Name = "NAT_EIP_${count.index + 1}"
  }

}

resource "aws_nat_gateway" "nat_gateway" {
  count         = length(var.public_cidr_block)
  allocation_id = element(aws_eip.nat_eip[*].id, count.index)
  subnet_id     = element(var.public_subnet_ids, count.index)

  tags = {
    Name = "NAT_Gateway_${count.index + 1}"
  }

}


resource "aws_route_table" "private_route_table" {
#   vpc_id = aws_vpc.VPC_medha.id
  vpc_id = var.vpc_id
  count  = length(var.private_cidr_block)


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.nat_gateway[*].id, count.index)
  }

  tags = {
    Name = "Private_Route_Table_${count.index + 1}"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(var.private_cidr_block)
  subnet_id     = element(var.private_subnet_ids, count.index)
  route_table_id = element(aws_route_table.private_route_table[*].id, count.index)
}