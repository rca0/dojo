# Global variables

variable "my-ip" {
  description = "Define my real ip"
  default = "200.200.200.200/32"
}

variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "vpc_name" {
  default = "Define VPC name"
  default = "vpc-ruan-us-east-1"
}

variable "igw-tag" {
  description = "Tag name for Internet Gateway"
  default = "igw-ruan-us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.200.0.0/16"
}

variable "public_subnet_cidr_1a" {
  description = "CIDR for the public subnet"
  default = "10.200.0.0/20"
}

variable "private_subnet_cidr_1a" {
  description = "CIDR for the public subnet"
  default = "10.200.16.0/20"
}

variable "subnet-pb-tag-1a" {
  description = "Tag name for Public Subnet AZ 1a"
  default = "subnet-ruan-pb-1a"
}

variable "subnet-pv-tag-1a" {
  description = "Tag name for Private Subnet AZ 1a"
  default = "subnet-ruan-pv-1a"
}

variable "rt-pb-tag-1a" {
  description = "Tag name for Public Subnet Route Table"
  default = "rt-pb-ruan-us-east-1a"
}

variable "rt-pv-tag-1a" {
  description = "Tag name for the Private Subnet Route Table"
  default = "rt-pv-ruan-us-east-1a"
}

variable "public_subnet_cidr_1b" {
  description = "CIDR for the public subnet"
  default = "10.200.32.0/20"
}

variable "subnet-pb-tag-1b" {
  description = "Tag name for the Public Subnet AZ 1b"
  default = "subnet-ruan-pb-1b"
}

variable "private_subnet_cidr_1b" {
  description = "CIDR for the public subnet"
  default = "10.200.48.0/20"
}

variable "subnet-pv-tag-1b" {
  description = "Tag name for the Private Subnet AZ 1b"
  default = "subnet-ruan-pv-1b"
}

variable "rt-pb-tag-1b" {
  description = "Tag name for the Public Subnet Route Table"
  default = "rt-pb-ruan-us-east-1b"
}

variable "rt-pv-tag-1b" {
  description = "Tag name for the Private Subnet Route Table"
  default = "rt-pv-ruan-us-east-1b"
}

variable "network-acl-pv" {
  description = "Network ACL for Private Subnet"
  default = "ntw-acl-pv-ruan-us-east-1"
}

variable "network-acl-pb" {
  description = "Network ACL for Public Subnet"
  default = "ntw-acl-pb-ruan-us-east-1"
}
