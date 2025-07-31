provider "aws" {
    region = "us-east-1"  
}
resource "aws_launch_template" "launch_template_home" {
    name = "launch-template-home"
    image_id = var.image_id
    instance_type = var.instance_type
    vpc_security_group_ids = var.security_group_ids
    user_data = filebase64("home.sh")
   
    key_name = var.key_pair
    tags = {
      env = var.env
    }  
}

resource "aws_autoscaling_group" "asg_home" {
    name = "asg-home"
    max_size = var.max_size
    min_size = var.min_size
    desired_capacity = var.desired_capacity
    launch_template {
    id = aws_launch_template.launch_template_home.id
    version = "$Latest"
  }
  availability_zones = var.availabity_zone
  
  tag {
      key = "env"
      value = var.env
      propagate_at_launch = true
  }
  target_group_arns = [aws_lb_target_group.tg_home.arn]
}

resource "aws_autoscaling_policy" "asg_home" {
    name = "asg-home"
    autoscaling_group_name = aws_autoscaling_group.asg_home.name
    policy_type = "TargetTrackingScaling"
    target_tracking_configuration {
      predefined_metric_specification {
        predefined_metric_type = "ASGAverageCPUUtilization"
      }
      target_value = 50
    }     
}
resource "aws_lb_target_group" "tg_home" {
    name = "tg-home"
    port = 80
    protocol = "HTTP"
    vpc_id = var.vpc_id
    tags = {
       env = var.env 
    } 
    health_check {
      path = "/"
    } 
}


resource "aws_lb" "app_lb" {
    name = "app-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [aws_security_group.alb_sg.id]
    subnets = var.subnets

    tags = {
        env =var.env
    }
}

resource "aws_security_group" "alb_sg" {
    name = "alb-sg"
    ingress{
        protocol = "-1"
        to_port = 0
        from_port = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        protocol = "TCP"
        to_port = 80
        from_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        protocol = "TCP"
        to_port = 22
        from_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        protocol = "-1"
        to_port = 0
        from_port = 0
        cidr_blocks = ["0.0.0.0/0"]

    }
    egress {
        protocol = "TCP"
        to_port = 80
        from_port = 80
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        protocol = "TCP"
        to_port = 22
        from_port = 22
        cidr_blocks = ["0.0.0.0/0"]
    }
    description =  "22 & 80 port ar enable"  
}
resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_home.arn
  }
}

