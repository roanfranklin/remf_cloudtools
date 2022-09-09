resource "aws_vpc" "vpc_env" {{
  cidr_block           = var.cidr_env
  
  enable_dns_hostnames = {vpc_enable_dns_hostnames}
  enable_dns_support   = {vpc_enable_dns_support}
  assign_generated_ipv6_cidr_block = {vpc_assign_generated_ipv6_cidr_block}

  tags = {tags_vpc}
}}
