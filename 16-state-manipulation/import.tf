/*
Import via CLI
Import via import blocj
*/

resource "aws_s3_bucket" "remote_state" {
  bucket = "terraform-state-20260915-a7f3c91e"

  tags = {
    ManagedBy = "Terraform"
    Lifecycle = "Critical"
  }

  lifecycle {
    prevent_destroy = true
  }
}

import {
  to = aws_s3_bucket_public_access_block.remote_state
  id = aws_s3_bucket.remote_state.bucket
}

resource "aws_s3_bucket_public_access_block" "remote_state" {
  bucket = aws_s3_bucket.remote_state.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}