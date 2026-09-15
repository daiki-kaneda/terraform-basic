/*
terraformのよく使われるコマンド一覧

terraform fmt (-recursive): .tfファイルのフォーマットを（サブディレクトリを含めて）整える
terraform validate : .tfファイルの文法をチェックする
terraform plan : 実行プランを表示する。実際にリソースに影響は与えない。 -outで実際にplanファイルを生成できる
terraform plan -destory : 削除プランを表示する
terraform apply : planを生成、実行する(planファイルを指定して直接実行もできる)
terraform show :　人間が読むことのできる形式で、stateまたはplanを表示できる（planは直接指定する）
terraform state list : stateの中にあるリソースのリストを表示する
terraform destroy : 管理しているすべてのリソースを削除する。 terraform apply -destroyと同一。 -auto-approveで承認ステップをスキップ。
terraform -help : terraformのコマンドのマニュアルを表示する 
*/

/*
Stateについて

State...設定ファイルのリソースを現実のリソースと対応づけるもの

- Stateは常にTerraformにおいて必須
- 機密情報を含むので、アクセス制限が重要
- State fileにはメタデータや依存関係（どの順序で作成、削除、更新されるか）などのデータも含まれる
- Stateファイルはplan実行前に、実際にあるリソースに対応づけてリフレッシュされる。
    （もし、ここでconfiguration drift,ズレがあれば、Terraformは外部で行われた変更を元に戻す)
- Stateはローカル、S3,Google Cloud Storage, Terraform Cloudなどに保存できる
- Stateに書き込まれているときは、競合が起きないようにロックできる
*/

/*
Backendについて

Backend...Stateファイルをどこに保存するかを定めるもの.以下の３種類がある。
- Local...ローカルのプロジェクトと同じ場所に保存される。
- HCP Terraform...Terraformが提供するリモートバックエンド。さまざまな機能がある。
- Third party remote backend...S3やGoogle Cloud Storageなど
*/

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
}

provider "aws" {
  region = "eu-west-1"
}
