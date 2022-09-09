output "bucket_website_frontend" {{
  description = "bucket Frontend Name"
  value       = aws_s3_bucket.s3_bucket.id
}}

output "bucket_website_frontend_arn" {{
  description = "bucket Frontend ARN Name"
  value       = aws_s3_bucket.s3_bucket.arn
}}
