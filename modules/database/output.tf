output "rds_endpoint" {
  description = "RDS endpoint"
  value       = aws_db_instance.rds.endpoint
}

output "rds_id" {
  description = "RDS instance ID"
  value       = aws_db_instance.rds.id
}
