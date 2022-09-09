resource "aws_db_subnet_group" "env-dbsng" {{
  name       = "{env_lower}-db-subnet-group-rds-{engine}"
  subnet_ids = [
{list_az_db_subnet_group}
  ]

  tags = {{
    Name = "{env_lower}-db-subnet-group-rds-{engine}"
  }}
}}