module "networking-tf-course" {
  source  = "daiki-kaneda/networking-tf-course/aws"
  version = "0.1.2"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "14-use-own-module"
  }
  subnet_config = {
    subnet_1 = {
      cidr_block = "10.0.0.0/24"
      az         = "eu-west-1a"
    }
    subnet_2 = {
      cidr_block = "10.0.1.0/24"
      az         = "eu-west-1a",
      public     = true
    }
  }
}