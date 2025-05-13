variable "name" {
  description = "Name prefix for database resources"
  type        = string
}

variable "engine" {
  description = "Database engine (e.g., mysql, postgres)"
  type        = string
}

variable "engine_version" {
  description = "Engine version"
  type        = string
}

variable "instance_class" {
  description = "Database instance class"
  type        = string
}

variable "username" {
  description = "Master database username"
  type        = string
}

variable "password" {
  description = "Master database password"
  type        = string
  sensitive   = true
}

variable "database_subnet_ids" {
  description = "List of subnet IDs for DB subnet group"
  type        = list(string)
}

variable "db_sg_id" {
  description = "Security group ID for the database"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GBs"
  type        = number
}

variable "max_allocated_storage" {
  description = "Maximum allocated storage in GBs (for autoscaling)"
  type        = number
}

variable "storage_type" {
  description = "Storage type (gp2, gp3, io1)"
  type        = string
}

variable "publicly_accessible" {
  description = "Whether the database should be publicly accessible"
  type        = bool
}
