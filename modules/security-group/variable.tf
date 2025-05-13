variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "web_port" {
  description = "Port on which web application is running"
  type        = number
}

variable "app_port" {
  description = "Port on which application server is running"
  type        = number
}

variable "db_port" {
  description = "Port on which database is running"
  type        = number
}
