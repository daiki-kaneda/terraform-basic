**Workspace**...一つのコードベースで複数の環境を扱う仕組み

- あるWorkspaceでCLIを使う場合、他のWorkspaceのリソースは関知されない
- 異なるワークスペースは異なる.tfstateファイルに対応している。
- Terraformプロジェクトは"default"という名前のワークスペースを初めから持っている
- ほとんどのリモートバックエンドはワークスペースに対応可能
- terraform.workspaceで現在のワークスペースにアクセス可能
  - ただし、terraform.workspaceを条件分岐で使用することは推奨されない。代わりに入力変数を使うことが推奨される.
    - 🙅‍♂️　```count = ${terraform.workspace}=="dev" ? 1:2```
    - 🙆‍♂️　```count = var.bucket_count```
  - dev.tfvars,staging.tfvars,prod.tfvarsの様なファイルを複数作り、```terraform apply -var-file="$(terraform workspace show).tfvars"```とするなど。(少し長いコマンドなので、aliasを作ると便利)
  - 
  - 基本コマンド
    - terraform workspace delete...ワークスペースを削除
    - terraform workspace list...ワークスペースのリストを表示
    - terraform workspace new...新しいワークスペースを作成
    - terraform workspace select...ワークスペースの切り替え (export TF_WORKSPACE=でも切り替え可能。環境変数が優先される)
    - terraform workspace show...現在のワークスペースの名前を表示