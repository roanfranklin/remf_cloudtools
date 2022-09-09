data "aws_iam_policy_document" "website_policy_{env_lower}" {{
  statement {{
    actions = [
      "s3:GetObject"
    ]
    principals {{
      identifiers = ["*"]
      type        = "AWS"
    }}
    resources = [
      "arn:aws:s3:::${{var.bucket_website_name}}-{env_lower}/*"
    ]
  }}
}}
