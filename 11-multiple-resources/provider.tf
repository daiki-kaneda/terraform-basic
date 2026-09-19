/*
count,for_eachについて

Meta引数、count,for_eachを使うことでコードの重複を避けることができる

*** count ***
- ０以上の作成するリソースの個数を渡す
- リソースまたはモジュールで使用可能
- タイプ.ラベル[index]で各リソースにアクセスできる
- ブロック内部で、count.indexは各リソースの対応するindexを表す


*** for_each ***
- mapまたはstringのsetを受け取る
- キー,バリューはeachキーワードを介してアクセスできる

--- メモ ---
- count=length(設定のlist)の様にする場合、設定のlistの要素の順序が変わるだけでリソースの削除と更新が起きるので、注意が必要。for_eachではその様なことは起こらない
*/

terraform {
  required_version = "> 1.7"
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