# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "3tier-vpc"
  }
}

# Public Subnets (Web Tier)
resource "aws_subnet" "web" {
  count             = length(var.web_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "web-subnet-${count.index}"
  }
}

# Private Subnets (App Tier)
resource "aws_subnet" "app" {
  count             = length(var.app_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.app_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "app-subnet-${count.index}"
  }
}

# Database Subnets
resource "aws_subnet" "database" {
  count             = length(var.db_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.db_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]
  tags = {
    Name = "db-subnet-${count.index}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
}

# NAT Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.web[0].id
}

# Route Table for Web (Public) Subnets
resource "aws_route_table" "web" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

# Route Table for App (Private) Subnets
resource "aws_route_table" "app" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
}

# Subnet Association - Web
resource "aws_route_table_association" "web" {
  count          = length(var.web_subnet_cidrs)
  subnet_id      = aws_subnet.web[count.index].id
  route_table_id = aws_route_table.web.id
}

# Subnet Association - App
resource "aws_route_table_association" "app" {
  count          = length(var.app_subnet_cidrs)
  subnet_id      = aws_subnet.app[count.index].id
  route_table_id = aws_route_table.app.id
}
