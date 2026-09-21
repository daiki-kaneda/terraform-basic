data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_subnet" "this" {
  count  = 2
  vpc_id = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.available.names[
    count.index % length(data.aws_availability_zones.available.names)
  ]
  cidr_block = "172.31.${count.index}.0/24"
}

check "high_availability" {
  assert {
    condition     = length(toset([for subnet in aws_subnet.this : subnet.availability_zone])) > 1
    error_message = <<-EOT
    一つのAZに全てのサブネットがあります。AZ間のディストリビューションを検討してください。
    EOT
  }
}