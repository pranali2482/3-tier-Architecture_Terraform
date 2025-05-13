variable "web_ami_id" {}
variable "web_instance_type" {}
variable "web_key_name"{}
variable "web_sg_id" {}
variable "alb_sg_id" {}
variable "vpc_id" {}
variable "web_desired_capacity" {}
variable "web_min_size" {}
variable "web_max_size" {}
variable "web_port" {}
variable "instance_profile_name" {}
variable "web_target_cpu_utilization" {}

variable "web_subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}   