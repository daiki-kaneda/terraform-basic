locals {
  allowed_instance_types = ["t2.micro", "t3.micro"]
}

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
}

resource "aws_instance" "this" {
  # VPCを指定しない場合、該当リージョンのデフォルトVPCに置かれる
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp3"
  }

  lifecycle {

    precondition {
      condition     = contains(local.allowed_instance_types, var.instance_type)
      error_message = <<-EOT
      インスタンスタイプが無効です。許可されているインスタンスタイプは以下の通りです。
      [${join(", ", local.allowed_instance_types)}]
      EOT
    }

    postcondition {
      condition     = self.public_ip == null
      error_message = "インスタンスにパブリックIPが付与されています。"
    }
  }
}

check "cost_center_check" {
  assert {
    condition     = can(aws_instance.this.tags.CostCenter) && aws_instance.this.tags.CostCenter != ""
    error_message = "CostCenterタグがEC2インスタンスにありません。"
  }
}
