resource "aws_s3_bucket" "hcp_tf" {
  bucket = "hcp-terraform-${random_id.this.hex}"

  tags = {
    CreatedBy = "HCP Terraform"
  }
}