variable "region" {{
  description = "Region default in secrets.tfvars"
}}

variable "rds_availability_zone" {{
  description = "RDS Availability Zone in secrets.tfvars"
}}

variable "rds_instance_class" {{
  description = "RDS Instance Class in secrets.tfvars"
}}

variable "rds_name" {{
  description = "RDS Itentifier in secrets.tfvars"
}}

variable "rds_engine" {{
  description = "RDS Engine in secrets.tfvars"
}}

variable "rds_engine_version" {{
  description = "RDS Engine Version in secrets.tfvars"
}}

variable "rds_parameter_group_name" {{
  description = "RDS Parameter Group Name in secrets.tfvars"
}}

variable "rds_database_{engine}" {{
  description = "Database MySQL in secrets.tfvars"
}}

variable "rds_username_{engine}" {{
  description = "Username database MySQL in secrets.tfvars"
}}

variable "rds_publicly_accessible" {{
  description = "Publicly Accessible in secrets.tfvars"
}}

variable "rds_password_{engine}" {{
  description = "Password database MySQL in secrets.tfvars"
  type        = string
  sensitive   = true
}}

variable "rds_allocated_storage" {{
  description = "Allocated Storage in secrets.tfvars"
}}

variable "rds_max_allocated_storage" {{
  description = "Max Allocated Storage in secrets.tfvars"
}}

variable "vpc_env_id" {{
  description = "VPC de env in secrets.tfvars"
}}

variable "vpc_env_cidr" {{
  description = "CIDR de env in secrets.tfvars"
}}
