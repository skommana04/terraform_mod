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
  source            = "../modules/network"
  cidr_block        = var.cidr_block
  public_cidr_block = var.public_cidr_block
  availability_zone = var.availability_zone
  private_cidr_block = var.private_cidr_block

}

module "natgateway" {
  source                = "../modules/natgateway"
  public_cidr_block  =    var.public_cidr_block
  private_cidr_block =    var.private_cidr_block
  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  private_subnet_ids    = module.vpc.private_subnet_ids
  
}

resource "aws_instance" "test_instance" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  key_name      = "ayaansh"
  subnet_id     = element(module.vpc.public_subnet_ids, 0)
  # vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = "EC2"
  }
}

module "security_gp" {
  source = "../modules/sg"
  vpc_id = module.vpc.vpc_id
  ingress_value = var.ingress_value

    
}
