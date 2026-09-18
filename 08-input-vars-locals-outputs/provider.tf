/*
Input Variableについて

Input Variable...外部から値を注入する仕組み

- variables.tfの内部で定義する慣習があり、var.<Name>でアクセスする
- デフォルトの値、senstiveかどうかの設定、バリデーションルールを設定可能
- terraform plan/applyを値を渡さずに実行すると、値の入力を求められる

**変数に値を提供する方法(優先度が低い順に)
- デフォルトの値
- 環境変数
- terraform.tfvars.file
- terraform.tfvars.json (terraform.tfvars,terraform.tfvars.jsonのみ自動で読み込まれる)
- *.auto.tfvars or *.auto.tfvars.json (terraform.tf.varsの任意の変数を上書きできる. 特定のキーのみを指定できる)
- commandline(-var or -var-file)

ステージングごとに環境を分ける際の推奨ディレクトリ構成メモ
├── modules/
│   └── app/              # 共通のインフラ定義（VPC、ECS、EC2など）
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── environments/
    ├── dev/              # dev 専用の State
    │   ├── provider.tf       # module "app" を呼び出し
    │   └── terraform.tfvars
    │
    └── prod/             # prod 専用の State
        ├── provider.tf       # module "app" を呼び出し
        └── terraform.tfvars
*/
terraform {
  required_version = "> 1.7.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  # リージョンを変数化するのは推奨されない
  region = "eu-west-1"
}