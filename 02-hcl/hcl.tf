# terraformブロックではbackend,バージョン、providerなどの設定をする
# terraformブロックでは定数のみを使うことができる
# backendでstateの保存場所(S3など）を指定、cloudでHCP Terraformの設定ができる
terraform {
  required_version = "1.7.0" # version指定には =,!=,>,<,>=,<=が使える
    # 必要なクラウドプロバイダーを指定
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.33.0" # ~>: 最も右の数字のみのインクリメントが許可される
    }
  }
}

# 自身のTerraform Projectによって管理されるもの
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.bucket_name
}

# 他の場所で管理されるもので、自身のプロジェクトで使いたいもの
data "aws_s3_bucket" "my_external_bucket" {
  bucket = "not-managed-by-us"
}

# 外部から値を注入するための仕組み
variable "bucket_name" {
  type = "string"
  description = "My valuable used to set bucket name"
  default = "my_default_bucket_name"
}

# apply時に表示したい値
output "bucket_id" {
  value = aws_s3_bucket.my_bucket.id
}

# 一時的な変数を使うための仕組み
locals {
  local_example = "This is a local variable"
}

# Terraformの設定のまとまりを部品化して再利用するためのもの
module "my_module" {
  source = "./module-example"
}