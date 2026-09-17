resource "aws_instance" "web" {
  ami                         = "ami-0652a081025ec9fee" # eu-west-1のUbuntuイメージ
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.public.id
  associate_public_ip_address = true
  vpc_security_group_ids = [
    aws_security_group.public_http_traffic.id
  ]
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

  # terraform apply -replace="aws_instance.web"の方が安全
  # user_data_replace_on_change = true

  tags = merge(local.common_tags, {
    Name = "06-resources-main"
  })

  lifecycle {
    create_before_destroy = true
    # ignore_changesは外部で手作業などで行われた変更をTerraformに無視させる
    ignore_changes = [tags]
  }
}

resource "aws_security_group" "public_http_traffic" {
  description = "Security group allowing trrafic on 80 and 443 ports"
  name        = "public-http-traffic"
  vpc_id      = aws_vpc.main.id
  tags = merge(local.common_tags, {
    Name = "06-resources-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = "80"
  to_port           = "80"
  ip_protocol       = "tcp"
}

# Nginxのパッケージをインストールするためのアウトバウンドルール
resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.public_http_traffic.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}