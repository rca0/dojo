## CloudFormation

It is used just for create an user and export AWS credentials.

## AWS Credentials

file: `main.tf`

```bash
provider "aws" {
  region = "us-east-1"
  profile = "sandbox"
}
```

- Create profile

`aws configure --profile sandbox`

Define vars in `~/.aws/credentials`

* AWS_ACCESS_KEY_ID
* AWS_SECRET_ACCESS_KEY
* AWS_REGION

## Steps to create a cluster in Amazon

- Create an IAM Resource
- Create a VPC
- Create an Internet Gateway
- Create a Public Subnet
- Create a Routing Table
- Associate the Routing Table to the Public Subnet
- Create a Security group for the VPC

Commands

terraform init

terraform plan

terraform apply

terraform destroy
