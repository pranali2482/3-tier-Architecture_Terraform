output "app_alb_dns_name" {
  description = "DNS name of the app ALB"
  value       = aws_lb.app.dns_name
}

output "app_target_group_arn" {
  description = "ARN of the app ALB Target Group"
  value       = aws_lb_target_group.app.arn
}
