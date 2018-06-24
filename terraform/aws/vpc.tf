# AWS VPC Example

# Define a VPC
resource "aws_vpc" "vpc-ruan" {
  cidr_block = "${var.vpc_cidr}"
  tags {
    Name = "${var.vpc_name}"
  }
}

# AZ A
# Public Subnet AZ A
resource "aws_subnet" "subnet-ruan-pb-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "${var.public_subnet_cidr_1a}"
  availability_zone = "us-east-1a"
  tags {
    Name = "${var.subnet-pb-tag-1a}"
  }
}

# Private Subnet AZ A
resource "aws_subnet" "subnet-ruan-pv-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "${var.private_subnet_cidr_1a}"
  availability_zone = "us-east-1a"
  tags {
    Name = "${var.subnet-pv-tag-1a}"
  }
}

# AZ B
# Public Subnet AZ A
resource "aws_subnet" "subnet-ruan-pb-1b" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "${var.public_subnet_cidr_1b}"
  availability_zone = "us-east-1b"
  tags {
    Name = "${var.subnet-pb-tag-1b}"
  }
}

# Private Subnet AZ B
resource "aws_subnet" "subnet-ruan-pv-1b" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "${var.private_subnet_cidr_1b}"
  availability_zone = "us-east-1b"
  tags {
    Name = "${var.subnet-pv-tag-1b}"
  }
}

# Internet Gateway for the Public Subnet AZ A
resource "aws_internet_gateway" "igw-ruan" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  tags {
    Name = "${var.igw-tag}"
  }
}

# Elastic IP (EIP) AZ A
resource "aws_eip" "eip" {
  vpc = true
  depends_on = ["aws_internet_gateway.igw-ruan"]
}


# NAT Gateway for the Private subnet 1a
resource "aws_nat_gateway" "natgw-pv-ruan-1a" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.subnet-ruan-pv-1a.id}"
  depends_on    = ["aws_internet_gateway.igw-ruan"]
  tags {
    Name = "natgw-pv-ruan-1a"
  }
}

# NAT Gateway for the Private subnet 1b
resource "aws_nat_gateway" "natgw-pv-ruan-1b" {
  allocation_id = "${aws_eip.eip.id}"
  subnet_id     = "${aws_subnet.subnet-ruan-pv-1b.id}"
  depends_on    = ["aws_internet_gateway.igw-ruan"]
  tags {
    Name = "natgw-pv-ruan-1b"
  }
}

# AZ A
# Routing table for Public Subnet AZ 1a
resource "aws_route_table" "rt-pb-ruan-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw-ruan.id}"
  }
  tags {
    Name = "${var.rt-pb-tag-1a}"
  }
}

# Routing table for Private Subnet AZ 1a
resource "aws_route_table" "rt-pv-ruan-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  route {
    cidr_block = "${var.private_subnet_cidr_1a}"
    gateway_id = "${aws_nat_gateway.natgw-pv-ruan-1a.id}"
  }
  tags {
    Name = "${var.rt-pv-tag-1a}"
  }
}

# AZ B
# Routing table for Public Subnet AZ 1b
resource "aws_route_table" "rt-pb-ruan-1b" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw-ruan.id}"
  }
  tags {
    Name = "${var.rt-pb-tag-1b}"
  }
}

# Routing table for Private Subnet AZ 1b
resource "aws_route_table" "rt-pv-ruan-1b" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  route {
    cidr_block = "${var.private_subnet_cidr_1b}"
    gateway_id = "${aws_nat_gateway.natgw-pv-ruan-1b.id}"
  }
  tags {
    Name = "${var.rt-pv-tag-1b}"
  }
}

# AZ A
# Associate the routing table to Public Subnet
resource "aws_route_table_association" "assn-subnet-ruan-pb-1a" {
  subnet_id      = "${aws_subnet.subnet-ruan-pb-1a.id}"
  route_table_id = "${aws_route_table.rt-pb-ruan-1a.id}"
}

# Associate the routing table to Private Subnet
resource "aws_route_table_association" "assn-subnet-ruan-pv-1a" {
  subnet_id      = "${aws_subnet.subnet-ruan-pv-1a.id}"
  route_table_id = "${aws_route_table.rt-pv-ruan-1a.id}"
}

# AZ B
# Associate the routing table to Public Subnet
resource "aws_route_table_association" "assn-subnet-ruan-pb-1b" {
  subnet_id      = "${aws_subnet.subnet-ruan-pb-1b.id}"
  route_table_id = "${aws_route_table.rt-pb-ruan-1b.id}"
}

# Associate the routing table to Private Subnet
resource "aws_route_table_association" "assn-subnet-ruan-pv-1b" {
  subnet_id      = "${aws_subnet.subnet-ruan-pv-1b.id}"
  route_table_id = "${aws_route_table.rt-pv-ruan-1b.id}"
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
    from_port = -1
    to_port = -1
    protocol = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
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

# Define SSH Key Pair for our instances
# resource "aws_key_pair" "default" {
  # key_name = "vpc-test-key-pair"
  # public_key = "${file("${var.key_path}")}"
# }
