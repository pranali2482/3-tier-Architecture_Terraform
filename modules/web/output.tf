
output "web_alb_dns_name" {
  description = "DNS name of the web ALB"
  value       = aws_lb.web.dns_name
}

output "web_target_group_arn" {
  description = "ARN of the web ALB Target Group"
  value       = aws_lb_target_group.web.arn
}
