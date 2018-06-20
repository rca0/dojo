# Configure AWS profile

variable "region" {
  default = "us-east-1"
}

provider "aws" {
  region = "${var.region}"
  profile = "sandbox"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "ruan-us-east-1"
  acl = "private"
}
