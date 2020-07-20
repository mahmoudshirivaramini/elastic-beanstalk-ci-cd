variable "rds_allocated_storage" {
  type = number
}

variable "rds_engine" {
  type = string
}

variable "rds_engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "rds_identifier" {
  type = string
}

variable "rds_db_name" {
  type = string
}

variable "rds_db_username" {
  type = string
}

variable "rds_password" {
  type = string
}

variable "rds_multi_az" {
  type = bool
}

variable "subnet_ids" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "vpc_security_group_ids" {
  type = list(string)
}

variable "rds_storage" {
  type = string
}

variable "backup_retention_period" {
  type = number
}

variable "rds_final_snapshot_identifier" {
  type = string
}