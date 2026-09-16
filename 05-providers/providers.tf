/*
Providersについて

Provider...TerraformにリモートAPIとどのように操作するかを教えるもの.

- Terraformとは分離され、実装、管理されている。→オリジナルのプロバイダを作ることも可能
- 必要なproviderはterraformブロックで宣言する必要がある
- 親モジュールのproviderは子モジュールに引き継がれる
- providerのバージョンはterraformのバージョンと同様に設定できる.(=,!=,>,<,<=,>=,~>などが使える)

コマンド
terraform init -upgrade...providerのバージョンなどの設定を変更した際、依存関係を解決できる. Stateファイルには影響を与えない.
*/

terraform {
  required_version = "~> 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

# 二つ目のproviderの設定を作ることができる
provider "aws" {
  region = "us-east-1"
  # aliasは同じプロバイダを異なる設定で使う場合に使う
  alias = "us-east"
}

resource "aws_s3_bucket" "eu_west_1" {
  bucket = "random-bucket-jfajfdoifieujeijfijaidjf"
}

resource "aws_s3_bucket" "us_east_1" {
  bucket   = "random-bucket-394894839489398494399348"
  provider = aws.us-east
}