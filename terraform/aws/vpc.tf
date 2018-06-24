# AWS VPC Example

# Define a VPC
resource "aws_vpc" "vpc-ruan" {
  cidr_block = "${var.vpc_cidr}"
  tags {
    Name = "${var.vpc_name}"
  }
}

#########################################
# Internet Gateway
#########################################
resource "aws_internet_gateway" "igw-ruan" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  tags {
    Name = "${var.igw-tag}"
  }
}

#########################################
# Elastic IP
#########################################
resource "aws_eip" "eip-1a" {
  vpc = true
  depends_on = ["aws_internet_gateway.igw-ruan"]
}

resource "aws_eip" "eip-1b" {
  vpc = true
  depends_on = ["aws_internet_gateway.igw-ruan"]
}

#########################################
# Public Subnet
#########################################
resource "aws_subnet" "subnet-ruan-pb-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "${var.public_subnet_cidr_1a}"
  availability_zone = "us-east-1a"
  tags {
    Name = "${var.subnet-pb-tag-1a}"
  }
}

resource "aws_subnet" "subnet-ruan-pb-1b" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "${var.public_subnet_cidr_1b}"
  availability_zone = "us-east-1b"
  tags {
    Name = "${var.subnet-pb-tag-1b}"
  }
}

#########################################
# Private Subnet
#########################################
resource "aws_subnet" "subnet-ruan-pv-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "${var.private_subnet_cidr_1a}"
  availability_zone = "us-east-1a"
  tags {
    Name = "${var.subnet-pv-tag-1a}"
  }
}

resource "aws_subnet" "subnet-ruan-pv-1b" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  cidr_block = "${var.private_subnet_cidr_1b}"
  availability_zone = "us-east-1b"
  tags {
    Name = "${var.subnet-pv-tag-1b}"
  }
}

#########################################
# Public Routing table
#########################################
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

resource "aws_route_table_association" "assn-subnet-ruan-pb-1a" {
  subnet_id      = "${aws_subnet.subnet-ruan-pb-1a.id}"
  route_table_id = "${aws_route_table.rt-pb-ruan-1a.id}"
}

resource "aws_route_table_association" "assn-subnet-ruan-pb-1b" {
  subnet_id      = "${aws_subnet.subnet-ruan-pb-1b.id}"
  route_table_id = "${aws_route_table.rt-pb-ruan-1b.id}"
}


#########################################
# Private Routing table
#########################################
resource "aws_route_table" "rt-pv-ruan-1a" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgw-pv-ruan-1a.id}"
  }
  tags {
    Name = "${var.rt-pv-tag-1a}"
  }
}

resource "aws_route_table" "rt-pv-ruan-1b" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.natgw-pv-ruan-1b.id}"
  }
  tags {
    Name = "${var.rt-pv-tag-1b}"
  }
}

resource "aws_route_table_association" "assn-subnet-ruan-pv-1a" {
  subnet_id      = "${aws_subnet.subnet-ruan-pv-1a.id}"
  route_table_id = "${aws_route_table.rt-pv-ruan-1a.id}"
}

resource "aws_route_table_association" "assn-subnet-ruan-pv-1b" {
  subnet_id      = "${aws_subnet.subnet-ruan-pv-1b.id}"
  route_table_id = "${aws_route_table.rt-pv-ruan-1b.id}"
}

#########################################
# NAT GATEWAY
#########################################
resource "aws_nat_gateway" "natgw-pv-ruan-1a" {
  allocation_id = "${aws_eip.eip-1a.id}"
  subnet_id     = "${aws_subnet.subnet-ruan-pv-1a.id}"
  depends_on    = ["aws_internet_gateway.igw-ruan"]
  tags {
    Name = "natgw-pv-ruan-1a"
  }
}

resource "aws_nat_gateway" "natgw-pv-ruan-1b" {
  allocation_id = "${aws_eip.eip-1b.id}"
  subnet_id     = "${aws_subnet.subnet-ruan-pv-1b.id}"
  depends_on    = ["aws_internet_gateway.igw-ruan"]
  tags {
    Name = "natgw-pv-ruan-1b"
  }
}

#########################################
# Network ACL
#########################################
resource "aws_network_acl" "ntw-acl-pv-ruan-us-east-1" {
  vpc_id = "${aws_vpc.vpc-ruan.id}"

  # Inbound Rules
  ingress {
    rule_no = 100
    from_port = 0
    to_port = 0
    protocol = -1
    action = "allow"
    cidr_block = "${var.vpc_cidr}"
  }

  # Outbound rules
  egress {
    rule_no = 100
    from_port = 0
    to_port = 0
    protocol = -1
    action = "allow"
    cidr_block = "${var.vpc_cidr}"
  }

  tags {
    Name = "${var.network-acl-pv}"
  }
}

resource "aws_network_acl" "ntw-acl-pb-ruan-us-east-1" {
    vpc_id = "${aws_vpc.vpc-ruan.id}"

    # Inbound Rules
    ingress {
      rule_no = 100
      from_port = 0
      to_port = 0
      protocol = -1
      action = "allow"
      cidr_block = "${var.vpc_cidr}"
    }

    # HTTP
    ingress {
      rule_no = 200
      action = "allow"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }

    # HTTPS
    ingress {
      rule_no = 250
      action = "allow"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }

    # SSH
    ingress {
      rule_no = 300
      action = "allow"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_block = "${var.my-ip}"
    }

    # EPHEMERAL PORTS
    ingress {
      rule_no = 400
      action = "allow"
      from_port = 1024
      to_port = 65535
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }

    # Outbound rules
    egress {
      rule_no = 100
      from_port = 0
      to_port = 0
      protocol = -1
      action = "allow"
      cidr_block = "${var.vpc_cidr}"
    }

    # HTTP
    egress {
      rule_no = 200
      action = "allow"
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }

    # HTTPS
    egress {
      rule_no = 250
      action = "allow"
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }

    # SMTP
    egress {
      rule_no = 300
      action = "allow"
      from_port = 587
      to_port = 587
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }

    # EPHEMERAL PORTS
    egress {
      rule_no = 400
      action = "allow"
      from_port = 1024
      to_port = 65535
      protocol = "tcp"
      cidr_block = "0.0.0.0/0"
    }

    tags {
      Name = "${var.network-acl-pb}"
    }
}

#########################################
# Security Group
#########################################
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
