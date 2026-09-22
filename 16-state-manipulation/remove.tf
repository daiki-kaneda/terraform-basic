# resource "aws_s3_bucket" "my_new_bucket" {
#   bucket = "randomname-9-22-11-40-1234"
# }

removed {
  from = aws_s3_bucket.my_new_bucket
  lifecycle {
    destroy = false
  }
}