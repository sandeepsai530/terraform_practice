resource "aws_security_group" "alb_sg" {
  name = "asg-alb-sg"
  description = "Security group for ALB"

  vpc_id = aws_vpc.asg_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "asg-alb-sg"
  }
}

resource "aws_security_group" "ec2_sg" {
  name = "asg-ec2-sg"
  description = "Security group for EC2 instances"

  vpc_id = aws_vpc.asg_vpc.id

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

    tags = {
      Name = "asg-ec2-sg"
    }
}
