data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "compute" {
  source = "./modules/compute"
  ami_id = data.aws_ami.ubuntu.id
}

moved {
  from = aws_instance.new
  to   = aws_instance.new_instance
}
moved {
  from = aws_instance.new_instance
  to   = module.compute.aws_instance.this
}


