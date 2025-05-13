# Output VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

# Output Web (Public) Subnet IDs
output "web_subnet_ids" {
  description = "IDs of the web (public) subnets"
  value       = [for subnet in aws_subnet.web : subnet.id]
}

# Output App (Private) Subnet IDs
output "app_subnet_ids" {
  description = "IDs of the app (private) subnets"
  value       = [for subnet in aws_subnet.app : subnet.id]
}

# Output Database Subnet IDs
output "database_subnet_ids" {
  description = "IDs of the database subnets"
  value       = [for subnet in aws_subnet.database : subnet.id]
}

# Output Internet Gateway ID
output "internet_gateway_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.gw.id
}

# Output NAT Gateway ID
output "nat_gateway_id" {
  description = "The ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

# Output Elastic IP ID
output "nat_eip_id" {
  description = "The ID of the Elastic IP associated with the NAT Gateway"
  value       = aws_eip.nat.id
}

