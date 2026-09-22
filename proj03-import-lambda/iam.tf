import {
  to = aws_iam_role.lambda_execution_role
  id = "manually-created-lambda-role-i96nxyrs"
}

import {
  to = aws_iam_policy.execution_role_policy
  id = "arn:aws:iam::676206940596:policy/service-role/AWSLambdaBasicExecutionRole-7105f615-15fb-47fe-965d-82bd60fe2d52"
}

import {
  to = aws_iam_role_policy_attachment.execution_role_policy
  id = "manually-created-lambda-role-i96nxyrs/arn:aws:iam::676206940596:policy/service-role/AWSLambdaBasicExecutionRole-7105f615-15fb-47fe-965d-82bd60fe2d52"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}
data "aws_iam_policy_document" "execution_policy" {
  statement {
    actions   = ["logs:CreateLogGroup"]
    resources = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
  }

  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["${aws_cloudwatch_log_group.lambda.arn}:*"]
  }
}

resource "aws_iam_role" "lambda_execution_role" {
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
  name               = "manually-created-lambda-role-i96nxyrs"
  path               = "/service-role/"
}

resource "aws_iam_policy" "execution_role_policy" {
  name   = "AWSLambdaBasicExecutionRole-7105f615-15fb-47fe-965d-82bd60fe2d52"
  path   = "/service-role/"
  policy = data.aws_iam_policy_document.execution_policy.json
}

resource "aws_iam_role_policy_attachment" "execution_role_policy" {
  policy_arn = aws_iam_policy.execution_role_policy.arn
  role       = aws_iam_role.lambda_execution_role.name
}
