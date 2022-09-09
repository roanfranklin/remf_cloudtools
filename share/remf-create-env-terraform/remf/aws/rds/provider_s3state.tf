terraform {{
  required_version = ">= 1.0.4"
  backend "s3" {{
    encrypt                 = true
    bucket                  = "{project}-terraform-state"
    dynamodb_table          = "{project}-terraform-locks"
    region                  = "{region}"
    # workspace_key_prefix    = "{env_lower}"
    key                     = "{env_upper}/{service_upper}/terraform.tfstate"
  }}
}}