## Project04 RDS Module memo

- セキュリティを担保するためにvalidationは非常に重要
- ユーザフレンドリなエラーメッセージが重要
- for_each = to_set(var.some_list)の様にする場合、some_listの中身はPlan時に確定していなければならない。確定しておらず、特定のリソースを先に作成したい場合は、terraform apply -target=resource_type.resource.labelが便利
- data.aws_vpc_security_group_ruleでcountやfor_eachを使うのではなく、data.aws_vpc_security_group_rulesを使用する