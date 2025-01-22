provider "aws" {
  region = var.region

}

terraform {
  backend "s3" {
    bucket = "medhasrikanth236236"
    key    = "ayaansh"
    region = "us-east-1"
  }
}

module "vpc" {
  source             = "../modules/network"
  cidr_block         = var.cidr_block
  public_cidr_block  = var.public_cidr_block
  availability_zone  = var.availability_zone
  private_cidr_block = var.private_cidr_block

}
