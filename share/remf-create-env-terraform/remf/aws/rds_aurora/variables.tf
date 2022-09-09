variable "region" {
  default = "us-east-1"
}

variable "environment" {
  description = "Environment default in secret.tfvars"
}

variable "tags" {
  description = "tags default ambiente"
  type        = map(string)
  default = {
    "Name" = "prd-Opss-mysql"
  }
}

# ################
# VPC Subnets

variable "vpc_prd_id" {
  description = "VPC ID de PRD in secret.tfvars"
}

variable "vpc_prd_cidr" {
  description = "CIDR da VPC de PRD in secret.tfvars"
}

variable "subnet_private_az1_id" {
  description = "ID Subnet Private da AZ A - PRD in secret.tfvars"
}

variable "subnet_private_az2_id" {
  description = "ID Subnet Private da AZ B - PRD in secret.tfvars"
}

variable "subnet_private_az3_id" {
  description = "ID Subnet Private da AZ C - PRD in secret.tfvars"
}

# ##############
# RDS

variable "rds_cluster_name" {
  default = "rds-prd-cluster-mysql"
}

variable "rds_instance_class" {
  default = "db.t3.medium"
}

variable "rds_engine" {
  default = "aurora-mysql"
}

variable "rds_engine_version" {
  default = "5.7.12"
}

variable "rds_database_mysql" {
  description = "Database MySQL in secret.tfvars"
}

variable "rds_username_mysql" {
  description = "Username database MySQL in secret.tfvars"
}

variable "rds_password_mysql" {
  description = "Password database MySQL in secret.tfvars"
  type        = string
  sensitive   = true
}


# ##############
# 

variable "ipfixo_roan" {
  description = "IP Fixo do Roan in secret.tfvars"
}