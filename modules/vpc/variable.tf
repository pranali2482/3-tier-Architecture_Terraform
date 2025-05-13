# VPC CIDR Block
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

# Availability Zones
variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

# Web Subnet CIDRs (Public Subnets)
variable "web_subnet_cidrs" {
  description = "List of CIDR blocks for web (public) subnets"
  type        = list(string)
}

# App Subnet CIDRs (Private Subnets)
variable "app_subnet_cidrs" {
  description = "List of CIDR blocks for app (private) subnets"
  type        = list(string)
}

# Database Subnet CIDRs
variable "db_subnet_cidrs" {
  description = "List of CIDR blocks for database subnets"
  type        = list(string)
}
