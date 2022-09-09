terraform {
  required_version = ">= 1.0.4"
  backend "s3" {
    bucket         = "autoscar-terraform-state"
    key            = "PRD/RDS/MySQL/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "autoscar-terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}