terraform {
  required_version = "> 1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  cloud {
    organization = "daiki-kaneda"
    workspaces {
      name = "terraform-oidc"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}