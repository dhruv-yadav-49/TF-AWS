terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.55.0"
        }
    }
}

provider "aws" {
   region = "eu-north-1"
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
        ENV = "PROD"
        name = "my-vpc"
    }
}

data "aws_vpc" "name" {
    tags = {
        ENV = "PROD"
        Name = "my-vpc"
    }
}

data "aws_availability_zone" "name" {
    state = "available"
}

data "aws_subnet" "name" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.name.id]
    }
    tags = {
        Name = "private-subnet"
    }
}

resource "aws_instance" "myserver" {
    ami             = data.aws_ami.name.id
    instance_type   = "t3.nano"
    subnet_id       = data.aws_subnet.name.id
    security_groups = [data.aws_security_group.name.id]

    tags = {
        Name = "SampleServer"
    }
}

output "aws_zones" {
    value = data.aws_availability_zone.name
}

data "aws_caller_identity" "name" {
    
}

data "aws_region" "name" {
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
output "vpc_id" {
    value = data.aws_vpc.name.id
}