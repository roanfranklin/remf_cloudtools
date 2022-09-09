variable "region" {{
  description = "AWS REGION in ../env.tfvars"
}}

variable "cidr_env" {{
  description = "Default CIDR VPC"
  type        = string
}}

variable "cidr_2octectos" {{
  description = "Default CIDR 2 2rimeiros octetos of VPC"
  type        = string
}}

variable "subnets_public_total" {{
  description = "Default Total Subnets Public"
  type        = string
}}

variable "subnets_private_total" {{
  description = "Default Total Subnets Private"
  type        = string
}}
