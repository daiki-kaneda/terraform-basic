# outputsはterroform apply時に表示されるデータ
# terraform output output_labelでも表示可能
output "static_website_endpoint" {
  value = aws_s3_bucket_website_configuration.static_website.website_endpoint
}