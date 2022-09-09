output "rds_endpoint_{engine}" {{
  value = aws_db_instance.{engine}.endpoint
}}