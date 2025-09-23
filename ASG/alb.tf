resource "aws_alb" "app_lb" {
  name = "app-lb"
  load_balancer_type = "application"
  internal = false
  security_groups = [aws_security_group.alb_sg.id]
  subnets = aws_subnet.public_subnet[*].id
  depends_on = [ aws_internet_gateway.asg_igw ]
}

resource "aws_lb_target_group" "alb_ec2_tg" {
  name = "app-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.asg_vpc.id
  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200-399"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2
  }

    tags = {
        Name = "app-tg"
    }
}

resource "aws_lb_listener" "aws_lb_listener" {
  load_balancer_arn = aws_alb.app_lb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_ec2_tg.arn
  }
  tags = {
    Name = "app-lb-listener"
  }
}