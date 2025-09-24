resource "aws_vpc" "asg_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "asg-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count             = 3
  vpc_id            = aws_vpc.asg_vpc.id
  cidr_block        = cidrsubnet(aws_vpc.asg_vpc.cidr_block, 8, count.index)
  availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)

  tags = {
    Name = "asg-public-subnet-${count.index + 1}"
  }

}

resource "aws_subnet" "private_subnet" {
    count = 3
    vpc_id = aws_vpc.asg_vpc.id
    cidr_block = cidrsubnet(aws_vpc.asg_vpc.cidr_block, 8, count.index + 10)
    availability_zone = element(["us-east-1a", "us-east-1b", "us-east-1c"], count.index)

    tags = {
      Name = "asg-private-subnet-${count.index + 1}"
    }
}

resource "aws_internet_gateway" "asg_igw" {
  vpc_id = aws_vpc.asg_vpc.id

  tags = {
    Name = "asg-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.asg_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.asg_igw.id
  }

  tags = {
    Name = "asg-public-rt"
  } 
}

resource "aws_route_table_association" "public_rt_association" {
  count          = 3
  subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
  route_table_id = aws_route_table.public_route_table.id
  
}

resource "aws_eip" "asg_aws_eip" {
  domain = "vpc"
  depends_on = [ aws_internet_gateway.asg_igw ]

  tags = {
    Name = "asg-eip"
  }
}

resource "aws_nat_gateway" "asg-nat-gateway" {
  allocation_id = aws_eip.asg_aws_eip.id
  subnet_id = element(aws_subnet.public_subnet[*].id, 0)

  tags = {
        Name = "asg-nat-gateway"
    }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.asg_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.asg-nat-gateway.id
    }

  tags = {
    Name = "asg-private-rt"
  } 
}

resource "aws_route_table_association" "private_route_association" {
  count          = 3
  subnet_id      = element(aws_subnet.private_subnet[*].id, count.index)
  route_table_id = aws_route_table.private_route_table.id
  
}