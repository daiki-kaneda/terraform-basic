HCP Terraform...Terraformプロジェクトをリモートで管理できるサービス
- 以下の特徴がある
  - インフラの変更の承認に対するアクセス制限
  - 安全なステートと暗号化されたストレージ
  - 管理リソースのグラフ化
  - 組織内でのみ共有されるプライベートレジストリ
  - テラフォームプロジェクトのポリシー管理
  - (plan,applyなどの)履歴の表示
- 有料、無料プランがある
- リソースは各ワークスペースで管理され、各ワークスペースは組織で管理される
- ワークスペースはリソース定義ファイルや、環境、入力変数、ステートファイルを含む

Workspaces (in HCP Terraform)...中央集権的にワークスペースを管理する

- HCP Terraform内のプロジェクトの構成要素
- ロールベースの管理

| | Local Terraform | HCP Terraform |
|---|---|---|
| 設定ファイル | ディスクに保存 | VCSリポジトリ |
| Variables | .tfvarsなど様々な方法で渡される | ワークスペースに保存 |
| Stateファイル | ローカルに保存するか、リモートバックエンドを使用する | ワークスペースに保存 |
| Secrets | プロンプトや環境変数を使用 | ワークスペースに保存 |


```
以下のように、ローカルのTerraformのバージョンやOSはHCPテラフォームで実行されるものと異なる場合がある。
% terraform apply
Running apply in HCP Terraform. Output will stream here. Pressing Ctrl-C
will cancel the remote apply if it's still pending. If the apply started it
will stop streaming the logs, but will not stop the apply running remotely.
......
Terraform v1.16.4
on linux_amd64
Initializing plugins and modules...
......

% terraform --version
Terraform v1.15.8
on darwin_amd64
+ provider registry.terraform.io/hashicorp/random v3.9.1
```

- AWSへの認証はOIDCが最も推奨される。（学習目的で環境変数を使うものも試す）