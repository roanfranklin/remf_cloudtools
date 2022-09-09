
# ############
# Bucket-S3 BKP

output "bucket_website_frontend_bkp" {{
  description = "bucket Frontend BKP Name"
  value       = aws_s3_bucket.s3_bucket_bkp.id
}}

output "bucket_website_frontend_arn_bkp" {{
  description = "bucket Frontend BKP ARN Name"
  value       = aws_s3_bucket.s3_bucket_bkp.arn
}}
