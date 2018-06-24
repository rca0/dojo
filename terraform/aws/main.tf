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
resource "aws_route53_zone" "main" {
  name = "domain.io"
}

resource "aws_route53_record" "k8s" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  name = "k8s-ruan-us-east-1"
  type = "NS"
  ttl = "3600"
}

output "ns-servers" {
  value = "${aws_route53_zone.main.name_servers}"
}
