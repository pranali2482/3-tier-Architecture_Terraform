output "web_alb_dns_name" {
  description = "DNS name of the web ALB"
  value       = module.web_asg_lg.web_alb_dns_name
}

output "web_target_group_arn" {
  description = "Web ALB Target Group ARN"
  value       = module.web_asg_lg.web_target_group_arn
}

output "app_target_group_arn" {
  description = "App ALB Target Group ARN"
  value       = module.app_asg_lg.app_target_group_arn
}

output "rds_endpoint" {
  description = "RDS endpoint"
  value       = module.database.rds_endpoint
}