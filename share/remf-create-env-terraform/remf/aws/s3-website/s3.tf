resource "aws_s3_bucket" "s3_bucket" {{
  bucket = "${{var.bucket_website_name}}-{env_lower}"
  tags = {{
    "Name" = "${{var.bucket_website_name}}-{env_lower}"
  }}
  force_destroy = {force_destroy}
}}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {{
  bucket = aws_s3_bucket.s3_bucket.bucket
  acl    = "{acl}"
}}

resource "aws_s3_bucket_website_configuration" "s3_bucket_{env_lower}" {{
  bucket = aws_s3_bucket.s3_bucket.bucket

  index_document {{
    suffix = "{index_document}"
  }}

  error_document {{
    key = "{error_document}"
  }}
}}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {{
  bucket = aws_s3_bucket.s3_bucket.bucket
  policy = data.aws_iam_policy_document.website_policy_{env_lower}.json
}}
