# 1. VPC ID
# 2. Public Subnets - subnet_key => {subnet_id, availability_zone}
# 3. Private Subnets - subnet_key => {subnet_id, availability_zone}

locals {
  output_public_subnets = {
    for key in keys(local.public_subnets) : key => {
      subnet_id         = aws_subnet.this[key].id
      availability_zone = aws_subnet.this[key].availability_zone
  } }
  output_private_subnets = {
    for key in keys(local.private_subnets) : key => {
      subnet_id         = aws_subnet.this[key].id
      availability_zone = aws_subnet.this[key].availability_zone
  } }
}

output "vpc_id" {
  description = "作成されたVPCのID"
  value       = aws_vpc.this.id
}
output "public_subnets" {
  description = "作成されたパブリックサブネットのIDとAZ"
  value       = local.output_public_subnets
}
output "private_subnets" {
  description = "作成されたプライベートサブネットのIDとAZ"
  value       = local.output_private_subnets
}