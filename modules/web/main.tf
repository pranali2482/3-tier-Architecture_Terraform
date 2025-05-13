
# Internet-facing Load Balancer 
resource "aws_lb" "web" {
  name               = "web-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.web_subnet_ids
  enable_deletion_protection = false   #allow to delete alb from AWS console
  tags = {
    Name        = "app-alb"
  }
}

#Target Group
resource "aws_lb_target_group" "web" {
  name     = "web-tg"
  port     = var.web_port    #target group will listen(web app running port)
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    healthy_threshold   = 3    #AWS will consider the target healthy if it passes 3 consecutive health checks.
    unhealthy_threshold = 3
    timeout             = 20    #If a health check does not respond within 5 seconds, it will be considered a failure.
    interval            = 30
    matcher             = "200"
  }

    tags = {
    Name        = "web-target-group"
  }
}

# Listener for ALB 
resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn   #all HTTP traffic on port 80 will be forwarded to the web-target-group
  }
}

# Launch Template 
resource "aws_launch_template" "web" {
  name_prefix   = "web-lt-"
  image_id      = var.web_ami_id
  instance_type = var.web_instance_type
  key_name      = var.web_key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.web_sg_id]
    subnet_id                   = var.web_subnet_ids[0]
  }
   
   iam_instance_profile {
    name = var.instance_profile_name  # Link the IAM instance profile here
  }
  
  user_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF
            )


  tag_specifications {
  resource_type = "instance"
  tags = {
    Name = "web-instance"
  }
}

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group 
resource "aws_autoscaling_group" "web" {
  name                      = "web-asg"
  vpc_zone_identifier       = var.web_subnet_ids
  desired_capacity          = var.web_desired_capacity
  max_size                  = var.web_max_size
  min_size                  = var.web_min_size
  health_check_type         = "EC2"
  health_check_grace_period = 300
  force_delete              = true

  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
   

  target_group_arns = [aws_lb_target_group.web.arn]   #When ASG launches EC2,It automatically registers EC2 to the Load Balancer's Target Group

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Target Tracking Policy
resource "aws_autoscaling_policy" "web" {
  name                   = "web-target-tracking"
  autoscaling_group_name = aws_autoscaling_group.web.name
  policy_type            = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.web_target_cpu_utilization
  }
}
