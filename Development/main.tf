module "vpc" {
  source            = "../modules/network"
  cidr_block        = var.cidr_block
  public_cidr_block = var.public_cidr_block
  availability_zone = var.availability_zone

}
