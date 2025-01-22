resource "aws_subnet" "public_subnet" {
  count = length(var.public_cidr_block)
  vpc_id     = var.vpc_id
  cidr_block = var.public_cidr_block
  availability_zone = element(var.availability_zone, count.index)

#   public_cidr_block = "10.0.1.0/24"
  

  tags = {
    Name = "Public_Subnet_${count.index + 1}"
  }
}