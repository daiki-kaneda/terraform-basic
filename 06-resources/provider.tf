/*
Resourceについて

Resource...インフラの構成要素を表す基本的なブロック

- 属性の種類はリソースのタイプによる
- モジュール内でリソースタイプと名前の組み合わせは一意でなければならない
- provider属性によって、使用するproviderを指定できる。指定しない場合,デフォルトのproviderが使用される。
- ランダムな文字列を表すリソースなど、ローカルでしか使わないリソースもある
- for_each,countなどによって、複数のリソースを作成する繰り返し処理もできる

Resourceの依存関係について
- 依存関係に基づいて並列、直列でのリソースの作成が可能
- depends-on属性を用いて、依存関係を明示的に作ることもできる
- replace-triggered-by属性を用いて、子リソースが修正された時に、親リソースも置き換えるようにできる

Meta引数について
Meta引数(Meta arguments)...Terraform本体にリソースの使い方を指示するもの

- depends_on...明示的にリソースの依存関係を指定する
- count,for_each...同じリソースタイプのリソースをひとつのリソースブロックで作成するためのもの
- provider...明示的に使用するproviderを指定するためのもの
LIFECYCLE
- create_before_destroy...削除する前にリソースを作成するようにする
- replace_triggered_by...参照しているリソースが変更されたら自身も置き換える
- prevent_destroy...削除しようとした時にエラーga起こるようにする
- ignore_changes...外部から変更されても、その変更を無視するリソースを指定する

*/

terraform {
  required_version = "~> 1.7"
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