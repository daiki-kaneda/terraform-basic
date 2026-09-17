data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # 
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  # リージョンを指定するにはproviderを指定する
  # provider = aws.eu_east
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_vpc" "prod_vpc" {
  tags = {
    Env = "Prod"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_policy_document" "static_website" {
  statement {
    sid = "PublicReadGetObject"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.public_read_bucket.arn}"]
  }
}


output "prod_vpc_id" {
  value = data.aws_vpc.prod_vpc.id
}
output "ubuntu_ami_data" {
  value = data.aws_ami.ubuntu.id
}

output "aws_caller_identity" {
  value = data.aws_caller_identity.current
}

output "aws_region" {
  value = data.aws_region.current
}

output "azs" {
  value = data.aws_availability_zones.available
}

output "iap_policy" {
  value = data.aws_iam_policy_document.static_website
}


resource "aws_s3_bucket" "public_read_bucket" {
  bucket = "public_read_bucket-ajfdojicif"
}

resource "aws_instance" "web" {
  # VPCを指定しない場合、該当リージョンのデフォルトVPCに置かれる
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }
  user_data = <<-EOF
            #!/bin/bash
            apt-get update -y
            apt-get install -y nginx
            systemctl enable nginx
            systemctl start nginx
            EOF

  lifecycle {
    create_before_destroy = true
    # ignore_changesは外部で手作業などで行われた変更をTerraformに無視させる
    ignore_changes = [tags]
  }
}