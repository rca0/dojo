# Global variables

variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "vpc_name" {
  default = "Define VPC name"
  default = "vpc-ruan-us-east-1"
}

# Tag name for Internet Gateway
variable "igw-tag" {
  default = "igw-ruan-us-east-1"
}

# Default CIDR VPC
variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.200.0.0/16"
}

# AZ A
# Public Subnet Mask /20
variable "public_subnet_cidr_1a" {
  description = "CIDR for the public subnet"
  default = "10.200.0.0/20"
}

# Private Subnet Mask /20
variable "private_subnet_cidr_1a" {
  description = "CIDR for the public subnet"
  default = "10.200.16.0/20"
}

# AZ A
# Tag name for Public Subnet AZ 1a
variable "subnet-pb-tag-1a" {
  default = "subnet-ruan-pb-1a"
}

# Tag name for Private Subnet AZ 1a
variable "subnet-pv-tag-1a" {
  default = "subnet-ruan-pv-1a"
}

# Tag name for Public Subnet Route Table
variable "rt-pb-tag-1a" {
  default = "rt-pb-ruan-us-east-1a"
}

# Tag name for Private Subnet Route Table
variable "rt-pv-tag-1a" {
  default = "rt-pv-ruan-us-east-1a"
}

# AZ B
# Public Subnet Mask /20
variable "public_subnet_cidr_1b" {
  description = "CIDR for the public subnet"
  default = "10.200.48.0/20"
}

# Tag name for Public Subnet AZ 1b
variable "subnet-pb-tag-1b" {
  default = "subnet-ruan-pb-1b"
}

# Private Subnet Mask /20
variable "private_subnet_cidr_1b" {
  description = "CIDR for the public subnet"
  default = "10.200.64.0/20"
}

# AZ B
# Tag name for Private Subnet AZ 1b
variable "subnet-pv-tag-1b" {
  default = "subnet-ruan-pv-1b"
}

# Tag name for Public Subnet Route Table
variable "rt-pb-tag-1b" {
  default = "rt-pb-ruan-us-east-1b"
}

# Tag name for Private Subnet Route Table
variable "rt-pv-tag-1b" {
  default = "rt-pv-ruan-us-east-1b"
}
