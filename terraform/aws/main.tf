# Configure AWS profile

variable "region" {
  default = "us-east-1"
}

provider "aws" {
  region = "${var.region}"
  profile = "sandbox"
}

# Store the cluster configuration
resource "aws_s3_bucket" "bucket" {
  bucket = "k8s-ruan-us-east-1"
  acl = "private"
}

# Create DNS Zone
resource "aws_route53_zone" "ruan" {
  name = "k8s-ruan-us-east-1.domain.io"
}
