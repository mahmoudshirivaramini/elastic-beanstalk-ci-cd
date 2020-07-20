resource "aws_db_subnet_group" "mysql-subnet" {
  name        = "mysql-subnet"
  description = "RDS subnet group"
  subnet_ids  = var.subnet_ids
}


resource "aws_db_parameter_group" "mysql-parameters" {
  name        = "mysql-params"
  family      = "mysql5.7"
  description = "mysql parameter group"


  parameter {
    name  = "max_allowed_packet"
    value = "16777216"
  }
}

resource "aws_db_instance" "mysql" {
  allocated_storage         = var.rds_allocated_storage
  engine                    = var.rds_engine
  engine_version            = var.rds_engine_version
  instance_class            = var.instance_class
  identifier                = var.rds_identifier
  name                      = var.rds_db_name
  username                  = var.rds_db_username
  password                  = var.rds_password
  db_subnet_group_name      = aws_db_subnet_group.mysql-subnet.name
  parameter_group_name      = aws_db_parameter_group.mysql-parameters.name
  multi_az                  = var.rds_multi_az
  vpc_security_group_ids    = var.vpc_security_group_ids
  storage_type              = var.rds_storage
  backup_retention_period   = var.backup_retention_period
  final_snapshot_identifier = var.rds_final_snapshot_identifier
  tags = {
    Name = "mysql-instance"
  }
}