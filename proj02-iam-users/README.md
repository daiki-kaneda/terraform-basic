以下の様なyamlファイルから以下を満たすIAMロールを複数作成する学習用プロジェクト

- 各IAMロールには適切なパーミッションポリシーがアタッチ
- 各IAMロールには適切なトラストポリシーがアタッチ
```
users:
- username: john
  roles: [readonly, developer]
- username: jane
  roles: [admin, auditor]
- username: bob
  roles: [readonly]
```

但し、単純化のために、以下のAWSマネジどポリシーを対応
```
    readonly = [
      "ReadOnlyAccess"
    ]
    admin = [
      "AdministratorAccess"
    ]
    auditor = [
      "SecurityAudit"
    ]
    developer = [
      "AmazonVPCFullAccess",
      "AmazonEC2FullAccess",
      "AmazonRDSFullAccess"
    ]
```