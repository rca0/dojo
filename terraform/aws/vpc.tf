# AWS VPC Example

# Define a VPC
resource "aws_vpc" "vpc-ruan" {
  cidr_block = "10.200.0.0/16"
  tags {
    Name = "vpc-ruan-us-east-1"
  }
}

# Internet Gateway for the Public Subnet
resource "aws_internet_gateway" "igw-ruan" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  tags {
    Name = "igw-ruan"
  }
}

# Elastic IP (EIP)
resource "aws_eip" "eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.igw-ruan"]
}

# NAT Gateway for the Private subnet
resource "aws_nat_gateway" "natgw-ruan" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.subnet-ruan-pv-1a.id}"
  depends_on    = ["aws_internet_gateway.igw-ruan"]
  tags {
    Name = "natgw-ruan"
  }
}

# Public Subnet AZ A
resource "aws_subnet" "subnet-ruan-pb-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "10.200.0.0/20"
  availability_zone = "us-east-1a"
  tags {
    Name = "subnet-ruan-pb-1a"
  }
}

# Private Subnet AZ A
resource "aws_subnet" "subnet-ruan-pv-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "10.200.16.0/20"
  availability_zone = "us-east-1a"
  tags {
    Name = "subnet-ruan-pv-1a"
  }
}

# Routing table for Public Subnet AZ 1a
resource "aws_route_table" "routetable-ruan-pb-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw-ruan.id}"
  }
  tags {
    Name = "routetable-ruan-pb-1a"
  }
}

# Routing table for Private Subnet AZ 1a
resource "aws_route_table" "routetable-ruan-pv-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  route {
    cidr_block = "10.200.16.0/20"
    gateway_id = "${aws_nat_gateway.natgw-ruan.id}"
  }
  tags {
    Name = "routetable-ruan-pv-1a"
  }
}

# Associate the routing table to Public Subnet
resource "aws_route_table_association" "assn-subnet-ruan-pb" {
  subnet_id      = "${aws_subnet.subnet-ruan-pb-1a.id}"
  route_table_id = "${aws_route_table.routetable-ruan-pb-1a.id}"
}

# Associate the routing table to Private Subnet
resource "aws_route_table_association" "assn-subnet-ruan-pv" {
  subnet_id      = "${aws_subnet.subnet-ruan-pv-1a.id}"
  route_table_id = "${aws_route_table.routetable-ruan-pv-1a.id}"
}

# ECS Instance Security Group
resource "aws_security_group" "public-sg" {
  name = "public-sg"
  description = "Public Access Security Group"
  vpc_id = "${aws_vpc.vpc-ruan.id}"

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # HTTP
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  # HTTPS
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  ingress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  # Allow All Traffic to Private Subnet
  egress {
    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = [
      "10.200.0.0/16"
    ]
  }

  tags {
    Name = "public-sg"
  }
}
