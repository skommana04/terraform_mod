module "vpc" {
  source            = "../modules/network"
  cidr_block        = var.cidr_block
  vpc_id            = module.network.vpc_id
  count             = length(var.public_cidr_block)
  public_cidr_block = element(var.public_cidr_block, count.index)
  availability_zone = element(var.availability_zone, count.index)

}
