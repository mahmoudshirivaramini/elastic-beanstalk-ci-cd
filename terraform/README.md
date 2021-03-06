# Deploying Elastic Benstalk Multicontainer Docker environments with Amazon RDS using Terraform

On the project, the following terraform providers used:
-  [hashicorp/null](https://github.com/hashicorp/terraform-provider-null)
-  [hashicorp/template](https://www.terraform.io/docs/providers/template/d/file.html)
-  [hashicorp/local](https://github.com/hashicorp/terraform-provider-local)
-  [hashicorp/aws](https://www.terraform.io/docs/providers/aws/index.html)

## High Level Design
![HLD](./docs/HLD.jpg)


## Requirements
To deploy the project, you will need an [AWS account](https://aws.amazon.com/) to follow along.The `profile` attribute on [providers.tf](./providers.tf) refers to the [AWS Config](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) File in `~/.aws/credentials` on MacOS and Linux. It is HashiCorp recommended practice that credentials never be hardcoded into *.tf configuration files.
To verify an AWS profile and ensure Terraform has correct provider credentials, install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html) and run `aws configure`. The AWS CLI will then verify and save your AWS Access Key ID and Secret Access Key.
There is two way to run this project:
* Local Environment
* Terraform Cloud

### Local Environment
On the first local deployment, install [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) and using bellow command to initialize a new Terraform working directory by creating initial files, downloading modules, etc.
```HCL
terraform init 
```
Generate an execution plan for Terraform. execution plan can be reviewed before running apply to get a sense for what Terraform will do:
```HCL
terraform plan -out terraform.out
```
The plan can be saved to `terraform.out` plan file, and apply to take the plan file to execute plan exactly:
```HCL
terraform apply "terraform.out"
```

### Terraform Cloud
Terraform Cloud is a service that makes it easy for teams to manage shared infrastructure with Terraform. The Terraform Cloud application, located at https://app.terraform.io, provides a UI and API to manage Terraform projects. Terraform Cloud offers a number of core features for free, as well as additional features in paid tiers. You can see a feature comparison here. When you host your project with Terraform Cloud, you can:
* Integrate with most popular version control systems.
* Manage your project's state, including state locking.
* Plan and apply configuration changes from within the Terraform Cloud UI.
* Securely store variables, including secret values.
* Store and use private Terraform modules.
* Collaborate with other users.

For start point, [create your terraform cloud account](https://learn.hashicorp.com/terraform/cloud-gettingstarted/tfc_signup), [create](https://learn.hashicorp.com/terraform/cloud-gettingstarted/tfc_create_workspace) and [setup](https://learn.hashicorp.com/terraform/cloud-gettingstarted/tfc_setup_workspace) workspace and at last, apply Configuration changes the projet and enjoy Terraform Cloud!


## Requirements

| Name | Version |
| ---- | ----------- |
| terraform	| ~> 0.12.0 |
| aws | ~> 2.0 |
| null | ~> 2.0 |



## Providers

| Name | Version |
|------|---------|
| aws | ~> 2.0 |


### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| additional\_security\_groups | List of security groups to be allowed to connect to the EC2 instances | `list(string)` | `[]` | no |
| additional\_settings | Additional Elastic Beanstalk setttings. For full list of options, see https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/command-options-general.html | <pre>list(object({<br>    namespace = string<br>    name      = string<br>    value     = string<br>  }))</pre> | <pre>{<br> namespace = "aws:elasticbeanstalk:environment:process:default" <br> name      = "StickinessEnabled"<br> value     = "false"< br>},<br>{ <br> namespace = "aws:elasticbeanstalk:managedactions"<br> name      = "ManagedActionsEnabled"<br> value     = "false"<br>}<br></pre> | no |
| alb\_zone\_id | ALB zone id | `map(string)` | <pre>{<br>  "ap-northeast-1": "Z1R25G3KIG2GBW",<br>  "ap-northeast-2": "Z3JE5OI70TWKCP",<br>  "ap-south-1": "Z18NTBI3Y7N9TZ",<br>  "ap-southeast-1": "Z16FZ9L249IFLT",<br>  "ap-southeast-2": "Z2PCDNR3VC2G1N",<br>  "ca-central-1": "ZJFCZL7SSZB5I",<br>  "eu-central-1": "Z1FRNW7UH4DEZJ",<br>  "eu-west-1": "Z2NYPWQ7DFZAZH",<br>  "eu-west-2": "Z1GKAAAUGATPF1",<br>  "eu-west-3": "ZCMLWB8V5SYIT",<br>  "sa-east-1": "Z10X7K2B4QSOFV",<br>  "us-east-1": "Z117KPS5GTRQ2G",<br>  "us-east-2": "Z14LCN19Q5QHIC",<br>  "us-west-1": "Z1LQECGX5PH1X",<br>  "us-west-2": "Z38NKT9BP95V3O"<br>}</pre> | no |
| allowed\_security\_groups | List of security groups to add to the EC2 instances | `list(string)` | `[]` | no |
| ami\_id | The id of the AMI to associate with the Amazon EC2 instances | `string` | `null` | no |
| application\_port | Port application is listening on | `number` | `80` | no |
| application\_subnets | List of subnets to place EC2 instances | `list(string)` | n/a | yes |
| associate\_public\_ip\_address | Whether to associate public IP addresses to the instances | `bool` | `false` | no |
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| autoscale\_lower\_bound | Minimum level of autoscale metric to remove an instance | `number` | `20` | no |
| autoscale\_lower\_increment | How many Amazon EC2 instances to remove when performing a scaling activity. | `number` | `-1` | no |
| autoscale\_max | Maximum instances to launch | `number` | `3` | no |
| autoscale\_measure\_name | Metric used for your Auto Scaling trigger | `string` | `"CPUUtilization"` | no |
| autoscale\_min | Minumum instances to launch | `number` | `2` | no |
| autoscale\_statistic | Statistic the trigger should use, such as Average | `string` | `"Average"` | no |
| autoscale\_unit | Unit for the trigger measurement, such as Bytes | `string` | `"Percent"` | no |
| autoscale\_upper\_bound | Maximum level of autoscale metric to add an instance | `number` | `80` | no |
| autoscale\_upper\_increment | How many Amazon EC2 instances to add when performing a scaling activity | `number` | `1` | no |
| availability\_zone\_selector | Availability Zone selector | `string` | `"Any 2"` | no |
| delimiter | Delimiter to be used between `name`, `namespace`, `stage`, etc. | `string` | `"-"` | no |
| deployment\_batch\_size | Percentage or fixed number of Amazon EC2 instances in the Auto Scaling group on which to simultaneously perform deployments. Valid values vary per deployment\_batch\_size\_type setting | `number` | `1` | no |
| deployment\_batch\_size\_type | The type of number that is specified in deployment\_batch\_size\_type | `string` | `"Fixed"` | no |
| deployment\_ignore\_health\_check | Do not cancel a deployment due to failed health checks | `bool` | `false` | no |
| deployment\_timeout | Number of seconds to wait for an instance to complete executing commands | `number` | `600` | no |
| description | Short description of the Environment | `string` | `""` | no |
| dns\_subdomain | The subdomain to create on Route53 for the EB environment. For the subdomain to be created, the `dns_zone_id` variable must be set as well | `string` | `""` | no |
| dns\_zone\_id | Route53 parent zone ID. The module will create sub-domain DNS record in the parent zone for the EB environment | `string` | `""` | no |
| elastic\_beanstalk\_application\_name | Elastic Beanstalk application name | `string` | n/a | yes |
| elb\_scheme | Specify `internal` if you want to create an internal load balancer in your Amazon VPC so that your Elastic Beanstalk application cannot be accessed from outside your Amazon VPC | `string` | `"public"` | no |
| enable\_log\_publication\_control | Copy the log files for your application's Amazon EC2 instances to the Amazon S3 bucket associated with your application | `bool` | `false` | no |
| enable\_spot\_instances | Enable Spot Instance requests for your environment | `bool` | `false` | no |
| enable\_stream\_logs | Whether to create groups in CloudWatch Logs for proxy and deployment logs, and stream logs from each instance in your environment | `bool` | `false` | no |
| enhanced\_reporting\_enabled | Whether to enable "enhanced" health reporting for this environment.  If false, "basic" reporting is used.  When you set this to false, you must also set `enable_managed_actions` to false | `bool` | `true` | no |
| env\_vars | Map of custom ENV variables to be provided to the application running on Elastic Beanstalk, e.g. env\_vars = { DB\_USER = 'admin' DB\_PASS = 'xxxxxx' } | `map(string)` | `{}` | no |
| environment | Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT' | `string` | `""` | no |
| environment\_type | Environment type, e.g. 'LoadBalanced' or 'SingleInstance'.  If setting to 'SingleInstance', `rolling_update_type` must be set to 'Time', `updating_min_in_service` must be set to 0, and `loadbalancer_subnets` will be unused (it applies to the ELB, which does not exist in SingleInstance environments) | `string` | `"LoadBalanced"` | no |
| force\_destroy | Force destroy the S3 bucket for load balancer logs | `bool` | `false` | no |
| health\_streaming\_delete\_on\_terminate | Whether to delete the log group when the environment is terminated. If false, the health data is kept RetentionInDays days. | `bool` | `false` | no |
| health\_streaming\_enabled | For environments with enhanced health reporting enabled, whether to create a group in CloudWatch Logs for environment health and archive Elastic Beanstalk environment health data. For information about enabling enhanced health, see aws:elasticbeanstalk:healthreporting:system. | `bool` | `false` | no |
| health\_streaming\_retention\_in\_days | The number of days to keep the archived health data before it expires. | `number` | `7` | no |
| healthcheck\_url | Application Health Check URL. Elastic Beanstalk will call this URL to check the health of the application running on EC2 instances | `string` | `"/healthcheck"` | no |
| http\_listener\_enabled | Enable port 80 (http) | `bool` | `true` | no |
| instance\_refresh\_enabled | Enable weekly instance replacement. | `bool` | `true` | no |
| instance\_type | Instances type | `string` | `"t2.micro"` | no |
| keypair | Name of SSH key that will be deployed on Elastic Beanstalk and DataPipeline instance. The key should be present in AWS | `string` | `""` | no |
| loadbalancer\_certificate\_arn | Load Balancer SSL certificate ARN. The certificate must be present in AWS Certificate Manager | `string` | `""` | no |
| loadbalancer\_managed\_security\_group | Load balancer managed security group | `string` | `""` | no |
| loadbalancer\_security\_groups | Load balancer security groups | `list(string)` | `[]` | no |
| loadbalancer\_ssl\_policy | Specify a security policy to apply to the listener. This option is only applicable to environments with an application load balancer | `string` | `""` | no |
| loadbalancer\_subnets | List of subnets to place Elastic Load Balancer | `list(string)` | `[]` | no |
| autoscale\_upper\_increment | How many Amazon EC2 instances to add when performing a scaling activity | `number` | `1` | no |
| loadbalancer\_type | Load Balancer type, e.g. 'application' or 'classic' | `string` | `"application"` | no |
| logs\_delete\_on\_terminate | Whether to delete the log groups when the environment is terminated. If false, the logs are kept RetentionInDays days | `bool` | `false` | no |
| logs\_retention\_in\_days | The number of days to keep log events before they expire. | `number` | `7` | no |
| managed\_actions\_enabled | Enable managed platform updates. When you set this to true, you must also specify a `PreferredStartTime` and `UpdateLevel` | `bool` | `true` | no |
| name | Solution name, e.g. 'app' or 'cluster' | `string` | n/a | yes |
| namespace | Namespace, which could be your organization name, e.g. 'eg' or 'cp' | `string` | `""` | no |
| preferred\_start\_time | Configure a maintenance window for managed actions in UTC | `string` | `"Sun:10:00"` | no |
| region | AWS region | `string` | n/a | yes |
| rolling\_update\_enabled | Whether to enable rolling update | `bool` | `true` | no |
| rolling\_update\_type | `Health` or `Immutable`. Set it to `Immutable` to apply the configuration change to a fresh group of instances | `string` | `"Health"` | no |
| root\_volume\_size | The size of the EBS root volume | `number` | `8` | no |
| root\_volume\_type | The type of the EBS root volume | `string` | `"gp2"` | no |
| solution\_stack\_name | Elastic Beanstalk stack, e.g. Docker, Go, Node, Java, IIS. For more info, see https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platforms-supported.html | `string` | `"64bit Amazon Linux 2018.03 v2.20.4 running Multi-container Docker 19.03.6-ce (Generic)"` | yes |
| spot\_fleet\_on\_demand\_above\_base\_percentage | The percentage of On-Demand Instances as part of additional capacity that your Auto Scaling group provisions beyond the SpotOnDemandBase instances. This option is relevant only when enable\_spot\_instances is true. | `number` | `-1` | no |
| spot\_fleet\_on\_demand\_base | The minimum number of On-Demand Instances that your Auto Scaling group provisions before considering Spot Instances as your environment scales up. This option is relevant only when enable\_spot\_instances is true. | `number` | `0` | no |
| spot\_max\_price | The maximum price per unit hour, in US$, that you're willing to pay for a Spot Instance. This option is relevant only when enable\_spot\_instances is true. Valid values are between 0.001 and 20.0 | `number` | `-1` | no |
| ssh\_listener\_enabled | Enable SSH port | `bool` | `false` | no |
| ssh\_listener\_port | SSH port | `number` | `22` | no |
| ssh\_source\_restriction | Used to lock down SSH access to the EC2 instances | `string` | `"0.0.0.0/0"` | no |
| stage | Stage, e.g. 'prod', 'staging', 'dev', or 'test' | `string` | `""` | no |
| tags | Additional tags (e.g. `map('BusinessUnit`,`XYZ`) | `map(string)` | `{}` | no |
| tier | Elastic Beanstalk Environment tier, 'WebServer' or 'Worker' | `string` | `"WebServer"` | no |
| update\_level | The highest level of update to apply with managed platform updates | `string` | `"minor"` | no |
| updating\_max\_batch | Maximum number of instances to update at once | `number` | `1` | no |
| updating\_min\_in\_service | Minimum number of instances in service during update | `number` | `1` | no |
| version\_label | Elastic Beanstalk Application version to deploy | `string` | `""` | no |
| vpc\_id | ID of the VPC in which to provision the AWS resources | `string` | n/a | yes |
| wait\_for\_ready\_timeout | The maximum duration to wait for the Elastic Beanstalk Environment to be in a ready state before timing out | `string` | `"20m"` | no |
| rds_allocated_storage | The allocated storage in gibibytes | `number` | `100` | yes |
| rds_engine |The database engine to use | `string` | `mysql` | yes |
| rds_engine_version | The engine version to use | `string` | `5.7` | no | 
| instance_class | The RDS instance class| `string` | `db.t2.small` | yes |
| rds_identifier |  The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier | `string` | `mysql` | no |
| rds_db_name | The name of the database to create when the DB instance is created. If this parameter is not specified, no database is created in the DB instance | `string` | `mydb` | no |
| rds_db_username | Username for the master DB user | `string` | `root` | yes | 
| rds_password | Password for the master DB user. Note that this may show up in logs, and it will be stored in the state file | `string`| `ChangeMe` | yes |
| rds_multi_az | Specifies if the RDS instance is multi-AZ | `boolean` |`false` | no |
| rds_storage  | One of "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD). The default is "io1" if iops is specified, "gp2" if not | `string` | `gp2` | no |
| backup_retention_period | The days to retain backups for. Must be between 0 and 35.  | `number` | `30` | no |
| rds_final_snapshot_identifier | Specifies whether or not to create this database from a snapshot. This correlates to the snapshot ID you'd find in the RDS console, e.g: rds:production-2015-06-26-06-05 | `string` | `mysql-final-snapshot` | no | 

## Outputs
| Name | Description |
|------|-------------|
| hostname | DNS hostname|