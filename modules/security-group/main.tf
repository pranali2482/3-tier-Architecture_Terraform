# Internet-facing ALB Security Group
resource "aws_security_group" "internet_alb_sg" {
  name        = "internet-alb-sg"
  description = "Allow HTTP/HTTPS traffic from the internet"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Web Server Security Group
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow traffic from Internet ALB"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow web app traffic from Internet ALB"
    from_port        = var.web_port
    to_port          = var.web_port
    protocol         = "tcp"
    security_groups  = [aws_security_group.internet_alb_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Internal ALB (App ALB) Security Group
resource "aws_security_group" "app_alb_sg" {
  name        = "app-alb-sg"
  description = "Allow traffic from Web servers"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow app traffic from Web SG"
    from_port        = var.app_port
    to_port          = var.app_port
    protocol         = "tcp"
    security_groups  = [aws_security_group.web_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# App Server Security Group
resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Allow traffic from App ALB"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow app server traffic from App ALB"
    from_port        = var.app_port
    to_port          = var.app_port
    protocol         = "tcp"
    security_groups  = [aws_security_group.app_alb_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Database Security Group
resource "aws_security_group" "db_sg" {
  name        = "db-sg"
  description = "Allow traffic from App Servers"
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow DB traffic from App Servers"
    from_port        = var.db_port
    to_port          = var.db_port
    protocol         = "tcp"
    security_groups  = [aws_security_group.app_sg.id]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
