variable "region" {}

# Variables for VPC
variable "vpc_cidr" {}
variable "web_subnet_cidrs" {
  type = list(string)
}
variable "app_subnet_cidrs" {
  type = list(string)
}
variable "db_subnet_cidrs" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}

# Variables for Security Groups
variable "web_port" {}
variable "app_port" {}
variable "db_port" {}

# Variables for IAM/SSM
# No input needed as per your structure, only output instance_profile_name

# Variables for Web ASG
variable "web_ami_id" {}
variable "web_instance_type" {}
variable "web_key_name" {}
variable "web_desired_capacity" {}
variable "web_min_size" {}
variable "web_max_size" {}
variable "web_target_cpu_utilization" {}

# Variables for App ASG
variable "app_ami_id" {}
variable "app_instance_type" {}
variable "app_key_name" {}
variable "app_desired_capacity" {}
variable "app_min_size" {}
variable "app_max_size" {}
variable "app_target_cpu_utilization" {}

# Variables for Database
variable "name" {}
variable "engine" {}
variable "engine_version" {}
variable "instance_class" {}
variable "username" {}
variable "password" {}
variable "allocated_storage" {}
variable "max_allocated_storage" {}
variable "storage_type" {}
variable "publicly_accessible" {}
