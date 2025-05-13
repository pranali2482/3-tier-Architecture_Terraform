# Internet-facing Load Balancer 
resource "aws_lb" "app" {
  name               = "app-alb"
  internal           = true  # Make the ALB internal
  load_balancer_type = "application"
  security_groups    = [var.alb_sg_id]
  subnets            = var.app_subnet_ids
  enable_deletion_protection = false   #allow to delete alb from AWS console
  tags = {
    Name        = "app-alb"
  }
}

# Target Group
resource "aws_lb_target_group" "app" {
  name     = "app-tg"
  port     = var.app_port    #target group will listen(app running port)
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
    Name        = "app-target-group"
  }
}

# Listener for ALB 
resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn   #all HTTP traffic on port 80 will be forwarded to the app-target-group
  }
}

# Launch Template 
resource "aws_launch_template" "app" {
  name_prefix   = "app-lt-"
  image_id      = var.app_ami_id
  instance_type = var.app_instance_type
  key_name      = var.app_key_name

  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.app_sg_id]
    subnet_id                   = var.app_subnet_ids[0]
  }
 
    iam_instance_profile {
    name = var.instance_profile_name  # Link the IAM instance profile here
  } 

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "app-instance"
    }
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Auto Scaling Group 
resource "aws_autoscaling_group" "app" {
  name                      = "app-asg"
  vpc_zone_identifier        = var.app_subnet_ids
  desired_capacity           = var.app_desired_capacity
  max_size                   = var.app_max_size
  min_size                   = var.app_min_size
  health_check_type          = "EC2"
  health_check_grace_period  = 300
  force_delete               = true

  launch_template {
    id      = aws_launch_template.app.id
    version = "$Latest"
  }
 
  target_group_arns = [aws_lb_target_group.app.arn]   #When ASG launches EC2, it automatically registers EC2 to the Load Balancer's Target Group

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Target Tracking Policy
resource "aws_autoscaling_policy" "app" {
  name                   = "app-target-tracking"
  autoscaling_group_name   = aws_autoscaling_group.app.name
  policy_type             = "TargetTrackingScaling"

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.app_target_cpu_utilization
  }
}
