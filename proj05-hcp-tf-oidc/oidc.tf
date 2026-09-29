import {
  to = aws_iam_openid_connect_provider.hcp_tf
  id = "arn:aws:iam::676206940596:oidc-provider/app.terraform.io"
}

import {
  to = aws_iam_role.hcp_terraform_admin
  id = "HCP-Terraform-ExcutionRole"
}

import {
  to = aws_iam_role_policy_attachment.hcp_terraform
  id = "${aws_iam_role.hcp_terraform_admin.name}/${data.aws_iam_policy.admin.arn}"
}

data "tls_certificate" "hcp_terraform" {
  url = "https://${var.hcp_terraform_hostname}"
}

resource "aws_iam_openid_connect_provider" "hcp_tf" {
  url             = data.tls_certificate.hcp_terraform.url
  client_id_list  = [var.hcp_terraform_audience]
  thumbprint_list = [data.tls_certificate.hcp_terraform.certificates[0].sha1_fingerprint]
}

data "aws_iam_policy_document" "terraform_oidc_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::676206940596:oidc-provider/app.terraform.io"]
    }

    condition {
      test     = "StringEquals"
      variable = "app.terraform.io:aud"
      values   = ["aws.workload.identity"]
    }

    condition {
      test     = "StringLike"
      variable = "app.terraform.io:sub"
      values = [
        for workspace in var.admin_role_workspaces :
        "organization:daiki-kaneda:project:Default Project:workspace:${workspace}:run_phase:*"
      ]
    }
  }
}
resource "aws_iam_role" "hcp_terraform_admin" {
  assume_role_policy = data.aws_iam_policy_document.terraform_oidc_assume_role.json
  description        = "iam role assumed by HCP Terraform via OIDC provider"
  name               = "HCP-Terraform-ExcutionRole"
}


data "aws_iam_policy" "admin" {
  arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
resource "aws_iam_role_policy_attachment" "hcp_terraform" {
  role       = aws_iam_role.hcp_terraform_admin.name
  policy_arn = data.aws_iam_policy.admin.arn
}