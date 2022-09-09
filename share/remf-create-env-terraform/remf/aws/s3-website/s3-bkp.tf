
# ############
# Bucket-S3 BKP

resource "aws_s3_bucket" "s3_bucket_bkp" {{
  bucket = "${{var.bucket_website_name}}-{env_lower}-bkp"
  tags = {{
    "Name" = "${{var.bucket_website_name}}-{env_lower}-bkp"
  }}
  force_destroy = {force_destroy}
}}

resource "aws_s3_bucket_acl" "s3_bucket_acl_bkp" {{
  bucket = aws_s3_bucket.s3_bucket_bkp.bucket
  acl    = "{acl}"
}}

resource "aws_s3_bucket_website_configuration" "s3_bucket_website_bkp" {{
  bucket = aws_s3_bucket.s3_bucket_bkp.bucket

  index_document {{
    suffix = "{index_document}"
  }}

  error_document {{
    key = "{error_document}"
  }}
}}

resource "aws_s3_bucket_policy" "s3_bucket_policy_bkp" {{
  bucket = aws_s3_bucket.s3_bucket_bkp.bucket
  policy = data.aws_iam_policy_document.website_policy_{env_lower}_bkp.json
}}
