locals {
  vpc_cidr             = "10.0.0.0/16"
  private_subent_cidrs = ["10.0.0.0/24"]
  public_subnet_cidrs  = ["10.0.128.0/24"]
}

data "aws_availability_zones" "azs" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.7.3"

  cidr            = local.vpc_cidr
  name            = local.project_name
  azs             = data.aws_availability_zones.azs.names
  private_subnets = local.private_subent_cidrs
  public_subnets  = local.public_subnet_cidrs

  tags = merge(local.common_tages, {})
}