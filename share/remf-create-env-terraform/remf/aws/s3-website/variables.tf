variable "region" {{
  description = "Default Region"
  type        = string
}}

variable "bucket_{name_s3_lower}_name" {{
  description = "Name of the S3 bucket in secrets.tfvars"
}}
