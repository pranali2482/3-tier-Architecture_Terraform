output "internet_alb_sg_id" {
  description = "ID of the Internet-facing ALB security group"
  value       = aws_security_group.internet_alb_sg.id
}

output "web_sg_id" {
  description = "ID of the Web Server security group"
  value       = aws_security_group.web_sg.id
}

output "app_alb_sg_id" {
  description = "ID of the Application ALB security group"
  value       = aws_security_group.app_alb_sg.id
}

output "app_sg_id" {
  description = "ID of the App Server security group"
  value       = aws_security_group.app_sg.id
}

output "db_sg_id" {
  description = "ID of the Database security group"
  value       = aws_security_group.db_sg.id
}
