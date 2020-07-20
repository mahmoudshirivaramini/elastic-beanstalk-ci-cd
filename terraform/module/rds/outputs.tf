output "full_string" {
  value       = tomap({ "RDS_HOSTNAME" = aws_db_instance.mysql.address, "RDS_PORT" = "3306", "RDS_DB_NAME" = "mydatabase", "RDS_USERNAME" = "root", "RDS_PASSWORD" = var.rds_password })
  description = "env_vars multi docker containers"
}

output "db_connection_string" {
  value       = aws_db_instance.mysql.address
  description = "The hostname of the RDS instance."
}