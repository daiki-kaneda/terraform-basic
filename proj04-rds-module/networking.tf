#####################
# VPCとサブネット
#####################

resource "aws_vpc" "custom" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "eu-west-1a"

  tags = {
    Name   = "subnet-custom-vpc"
    Access = "private"
  }
}
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.custom.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-1b"

  tags = {
    Name   = "subnet-custom-vpc"
    Access = "private"
  }
}


# 学習用で実際には使用しない
data "aws_vpc" "default" {
  default = true
}
resource "aws_subnet" "default" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.127.0/24"
}
resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.custom.id
  cidr_block = "10.0.128.0/24"

  tags = {
    Name   = "subnet-custom-vpc"
    Access = "public"
  }
}

#####################
# セキュリティグループ
#####################

# 1. Source security group
# 2. Allowed security group

resource "aws_security_group" "source" {
  name        = "source-sg"
  description = "Source SG to DB Security Group"
  vpc_id      = aws_vpc.custom.id
}
resource "aws_security_group" "compliant" {
  name        = "compliant-sg"
  description = "Compliant SG"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "db" {
  security_group_id            = aws_security_group.compliant.id
  referenced_security_group_id = aws_security_group.source.id
  from_port                    = 5432
  to_port                      = 5432
  ip_protocol                  = "tcp"
}

# 学習用で実際には使用しない
resource "aws_security_group" "non-compliant" {
  name        = "non-compliant-sg"
  description = "Non Copliant SG"
  vpc_id      = aws_vpc.custom.id
}

resource "aws_vpc_security_group_ingress_rule" "https" {
  security_group_id = aws_security_group.non-compliant.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}