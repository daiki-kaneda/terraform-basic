## Project03 Import Lambda Memo

- terraform plan の-generate-config-out=pathオプションで、import時にresourceブロックを自動生成できる
- 自動生成したファイルは必ずブラッシュアップするので、generated.tfの様な名前に一旦出力して、commitしない様にする方がいい
- インポートした設定ファイルのリファクタリングは非常に重要