## オブジェクトの検証

pre/postcondition,checkを使うことでより信頼性の高いインフラを構築できる
(いずれも入力変数の検証と同様に条件conditionとエラーメッセージerror_messageが必須)

**precondition**
- resourceブロックまたはdataブロックで使用される
- 自分自身を参照できない
- 参照するvariablesやdataの値などを検証できる。 (variableのvalidationブロックではその値しか検証できないので、外部のデータを検証に必要な場合に preconditionが使われる)

**postcondition**
- resourceブロックまたはdataブロックでつかわれる
- 自分自身を参照できる
- 作成したリソースの設定などの有効性を検証できる

**check**
- リソースブロックまたはデータブロックの外部から使用されるブロック
- Terraformプロジェクト内でアクセスできるものは全てアクセス可能
- 検証で失敗しても警告を出すだけで、applyプロセスを止めない

**pre/postconditionの検証が起きるタイミング**
- 検証に必要なデータすでにあればPlan時に!　（postconditionでもApply前からあるデータについての検証を書けば、Plan時に実行される）
- なければApply後に検証される

**メモ**
- postconditonにおける検証に失敗したら、失敗した後のリソースの作成は中断される
- create_before_destroy=trueとしている場合、postconditionに失敗したら、リソースを削除する前にapplyプロセスを中断できる