# VPC, subnets and route table

# My VPC configuration

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"
  enable_classiclink   = "false"
  tags = {
    Name = "my_vpc"
  }
}

# Internet gateway for VPC

resource "aws_internet_gateway" "my_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_gateway"
  }
}

# public subnet for EC2

resource "aws_subnet" "internet_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.AWS_ZONE1

  tags = {
    Name = "internet_subnet"
  }
}

# Private subnet for RDS

resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone       = var.AWS_ZONE2

  tags = {
    Name = "private_subnet"
  }
}

# Creating Subnet Group for RDS

resource "aws_db_subnet_group" "RDS_subnet_group" {
  name       = "db subnet group"
  subnet_ids = [aws_subnet.internet_subnet.id, aws_subnet.private_subnet.id]

  tags = {
    Name = "My DB subnet group"
  }
}

# Route table for internet

resource "aws_route_table" "rt_ec2" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_gateway.id
  }

  tags = {
    Name = "rt_ec2"
  }
}

# Route associations to public subnet

resource "aws_route_table_association" "assocoate_for_internet" {
  subnet_id      = aws_subnet.internet_subnet.id
  route_table_id = aws_route_table.rt_ec2.id
}


# Deafult route table which is uisng to associate private subnet

resource "aws_default_route_table" "Default-private" {
  default_route_table_id = aws_vpc.my_vpc.default_route_table_id

  tags = {
    Name = "private-route-table"
  }
}

# Route associations to private subnet 

resource "aws_route_table_association" "assocoate_for_internal_network" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_vpc.my_vpc.default_route_table_id
}

