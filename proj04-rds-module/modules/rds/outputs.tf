output "rds_instance_arn" {
  value       = aws_db_instance.this.arn
  description = "作成したRDSインスタンスのARNです。"
}

output "rds_instance_id" {
  value       = aws_db_instance.this.id
  description = "作成したRDSインスタンスのIDです。"
}

output "rds_instance_address" {
  value       = aws_db_instance.this.address
  description = "作成したRDSインスタンスのホストネームです。"
}

output "rds_instance_port" {
  value       = aws_db_instance.this.port
  description = "作成したRDSインスタンスのポートです。"
}

output "rds_instance_endpoint" {
  value       = aws_db_instance.this.endpoint
  description = "作成したRDSインスタンスのエンドポイントです。 フォーマット: <address>:<port>"
}

