output "vpc_id" {
  value = aws_vpc.asg_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet[*].id

}

output "private_subnet_id" {
  value = aws_subnet.private_subnet[*].id
  
}

output "eip" {
  value = aws_eip.asg_aws_eip.*.public_ip
}

output "aws_security_group_alb_sg_id" {
  value = aws_security_group.alb_sg.id
  
}

output "aws_security_group_ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
  
}