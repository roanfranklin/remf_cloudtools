# # ##########################################################
# # RDS Subnet_Group

resource "aws_db_subnet_group" "prd-dbsng" {
  name       = "${var.environment}-db-subnet-group-rds-mysql"
  subnet_ids = [
    var.subnet_private_az1_id,
    var.subnet_private_az2_id,
    var.subnet_private_az3_id
  ]

  tags = {
    Name = "${var.environment}-db-subnet-group-rds-mysql"
  }
}

# ##############
# RDS

resource "aws_rds_cluster_instance" "cluster_instances" {
  depends_on         = [aws_rds_cluster.cluster]
  identifier         = "${var.rds_cluster_name}-instance"
  cluster_identifier = aws_rds_cluster.cluster.id
  availability_zone  = "${var.region}c"
  instance_class     = var.rds_instance_class
  engine             = var.rds_engine
  engine_version     = var.rds_engine_version
  #writer = true
  db_subnet_group_name = aws_db_subnet_group.prd-dbsng.name
  #publicly_accessible  = true
}

resource "aws_rds_cluster" "cluster" {
  cluster_identifier     = var.rds_cluster_name
  availability_zones     = ["${var.region}c"]
  engine                 = var.rds_engine
  engine_version         = var.rds_engine_version
  database_name          = var.rds_database_mysql
  master_username        = var.rds_username_mysql
  master_password        = var.rds_password_mysql
  vpc_security_group_ids = ["${aws_security_group.prd-aurora-sg.id}"]
  skip_final_snapshot    = true
  db_subnet_group_name   = aws_db_subnet_group.prd-dbsng.name
}