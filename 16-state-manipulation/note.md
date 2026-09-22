## Stateファイルの操作について (State Manipulation)

Stateファイルを再生成、インポート、リファクタ、アントラックすることができる

**Recreate**
Stateファイルの設定を変えずに、管理しているリソースを再生成する。
```
terraform taint...特定のリソースをtainedとしてマークする
terraform untaint...tainedとしてのマークを削除
terraform apply -replace=...指定したリソースを設定を変更せずに再生成する
```

**Import**
既存のリソースをTerraformプロジェクトにインポートして、IaCで管理する様にする。
terraform importコマンドを使うか、importブロックを使用する。(インポートブロックを使って、applyを行うと、インポート後に設定ファイルの変更が適用される。planだけではimportされない。importブロックはその後削除できる)
インポートでは既存の外部リソースをStateファイルに追加するだけを行う。

```
import {
  to = "<resource>"
  id = "<resource-id>"
}

terraform import <resource-address> <resource-id>
```

**Refactor**
リソースを再生成することなしに、名前を変更したり、モジュールの外部に出したりする。
```
terraform state mv <resource_type.old_name> <resource_type.new_name>
でラベルのみを変更できる

例えば既存リソースにcount,for_eachなどを導入するが再生成したくない場合などは
terraform state mv <resource_type.old_name> <resource_type.new_name>[index or key]

movedブロックを使って明示的にコードに残すこともできる
moved {
    from = <resource_type.old_name>
    to   = <resource_type.new_name>
}

モジュールも指定可能（モジュール化したときなどに再生成したくない場合）
moved {
  from = aws_instance.new_instance
  to   = module.compute.aws_instance.this
}
```

**Untrack**
実際のインフラリソースを削除することなしにStateファイルからリソースを削除する。Terraformでの管理を止めるだけの操作.
terraform state rmコマンドかremovedブロックを使う。
```
terraform rm <resource_type>.<resource_label>

removed {
  from = aws_s3_bucket.my_new_bucket
  lifecycle {
    destroy = false # destroyをtrueにすると実際のリソースも削除される!
  }
}
```

**Generating Configuration**
ベストエフォートのTerraformの設定ファイルの自動生成。Importするときなどに使用可能.
