terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
}

provider "aws" {
    region = "us-east-1"
}

data "aws_ami" "name" {
    most_recent = true
    owners = ["amazon"]
}

output "aws_ami" {
    value = data.aws_ami.name.id
}

data "aws_security_group" "name" {
    tags = {
        Name = "nginx-sg"
    }
}

data "aws_vpc" "name" {
    tags = {
        Name = "my-vpc"
    }
}

data "aws_availability_zones" "name" {
    state = "available"
}

data "aws_subnet" "name" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.name.id]
    }

    tags = {
        Name = "public-subnet"
    }
}



resource "aws_instance" "myserver" {
    ami = "ami-04505e74c0741db8d"
    instance_type = "t3.micro"

    tags = {
      Name ="SampleServer"
    }
}

output "aws_zones" {
    value = data.aws_availability_zones.name.names
}

data "aws_region" "name" {
}

data "aws_caller_identity" "name" {
}

output "caller_info" {
    value = data.aws_caller_identity.name
}

output "region_name" {
    value = data.aws_region.name
}

output "security_group" {
    value = data.aws_security_group.name.id
}