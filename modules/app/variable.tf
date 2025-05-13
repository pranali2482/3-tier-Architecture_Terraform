variable "app_ami_id" {}
variable "app_instance_type" {}
variable "app_key_name" {}
variable "app_sg_id" {}  # Changed web_sg_id to app_sg_id
variable "alb_sg_id" {}
variable "vpc_id" {}
variable "app_desired_capacity" {}  # Changed web-desired_capacity to app_desired_capacity
variable "app_min_size" {}  # Changed web-min_size to app_min_size
variable "app_max_size" {}  # Changed web-max_size to app_max_size
variable "app_port" {}  # Changed web_port to app_port
variable "instance_profile_name" {}
variable "app_target_cpu_utilization" {}  # Changed web-target_cpu_utilization to app_target_cpu_utilization

variable "app_subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}
