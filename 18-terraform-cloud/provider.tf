terraform {
  required_version = "> 1.7.0"

  cloud {
    organization = "daiki-kaneda"
    workspaces {
      name = "terraform-cli"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}