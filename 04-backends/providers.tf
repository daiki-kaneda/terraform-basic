terraform {
  required_version = ">= 1.7.0"
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
  # terraform init -migrate-stateでbackend変更時に既存のstateファイルを移行できる
  backend "s3" {
    bucket = "terraform-state-20260915-a7f3c91e"
    key = "04-backends/state.tfstate"
    # state lockを可能にするフラグ
    use_lockfile = true
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}
