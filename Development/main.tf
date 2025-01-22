module "vpc" {
  source            = "../modules/network"
  cidr_block        = var.cidr_block
   count             = length(var.public_cidr_block)
  public_cidr_block = element(var.public_cidr_block, count.index)
  availability_zone = element(var.availability_zone, count.index)

}
