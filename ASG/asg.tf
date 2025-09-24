 resource "aws_launch_template" "asg_launch_template" {
    name = "asg-launch-template"

    image_id = var.image_id
    instance_type = var.instance_type

    network_interfaces {
      associate_public_ip_address = false 
      security_groups = [aws_security_group.ec2_sg.id]
    }

    user_data = filebase64("userdata.sh")

    tag_specifications {
      resource_type = "instance"
      tags = {
        Name = "asg-ec2-instance"
      }
    }
}

resource "aws_autoscaling_group" "ec2_asg" {
  name = "ec2-asg"
  desired_capacity = 2
  min_size = 1
  max_size = 4
  target_group_arns = [aws_lb_target_group.alb_ec2_tg.arn]
  vpc_zone_identifier = aws_subnet.private_subnet[*].id 

  launch_template {
    id = aws_launch_template.asg_launch_template.id
    version = "$Latest"
  }

  health_check_type = "ELB"
} 

resource "aws_autoscaling_policy" "cpu_target_tracking" {
  name                   = "cpu-target-tracking"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.ec2_asg.name

  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 70.0   # Keep CPU around 70%
  }
}