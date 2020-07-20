region = "us-east-1"

availability_zones = ["us-east-1a", "us-east-1b"]

namespace = "abt-cicd"

stage = "prod"

name = "abt-prod"

description = "productio eb"

tier = "WebServer"

environment_type = "LoadBalanced"

loadbalancer_type = "application"

availability_zone_selector = "Any 2"

instance_type = "t2.micro"

autoscale_min = 2

autoscale_max = 3

wait_for_ready_timeout = "20m"

force_destroy = true

rolling_update_enabled = false

rolling_update_type = "Health"

updating_min_in_service = 0

updating_max_batch = 1

healthcheck_url = "/healthcheck"

application_port = 80

root_volume_size = 8

root_volume_type = "gp2"

autoscale_measure_name = "CPUUtilization"

autoscale_statistic = "Average"

autoscale_unit = "Percent"

autoscale_lower_bound = 20

autoscale_lower_increment = -1

autoscale_upper_bound = 80

autoscale_upper_increment = 1

elb_scheme = "public"

solution_stack_name = "64bit Amazon Linux 2018.03 v2.20.4 running Multi-container Docker 19.03.6-ce (Generic)"

version_label = ""

dns_zone_id = "Z3SO0TKDDQ0RGG"

additional_settings = [
  {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "StickinessEnabled"
    value     = "false"
  },
  {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "false"
  }
]

rds_allocated_storage = 100

rds_engine = "mysql"

rds_engine_version = "5.7"

instance_class = "db.t2.small"

rds_identifier = "mysql"

rds_db_name = "mydb"

rds_db_username = "root"

rds_password = "ChangeMe"

rds_multi_az = false

rds_storage = "gp2"

backup_retention_period = 30

rds_final_snapshot_identifier = "mysql-final-snapshot"