resource "aws_db_instance" "{engine}" {{
  allocated_storage         = var.rds_allocated_storage
  max_allocated_storage     = var.rds_max_allocated_storage
  engine                    = var.rds_engine
  engine_version            = var.rds_engine_version
  identifier                = var.rds_name
  instance_class            = var.rds_instance_class
  name                      = var.rds_database_{engine}
  username                  = var.rds_username_{engine}
  password                  = var.rds_password_{engine}
  parameter_group_name      = var.rds_parameter_group_name
  availability_zone         = "${{var.region}}${{var.rds_availability_zone}}"
  #final_snapshot_identifier = "{final_snapshot_identifier}"
  #backup_retention_period   = var.rds_backup_retention_period
  skip_final_snapshot       = {skip_final_snapshot}
  vpc_security_group_ids    = ["${{aws_security_group.env-rds-sg.id}}"]
  db_subnet_group_name      = aws_db_subnet_group.env-dbsng.name
  publicly_accessible       = var.rds_publicly_accessible
}}