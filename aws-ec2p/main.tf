terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.54.1"
        }
    }
}

provider "aws" {
    region = var.region
}

resource "aws_instance" "myec2" {
    ami = "ami-0b5a4e51202cd98e5"
    instance_type = "t3.micro"

    tags = {
        Name = "SampleServer"
    }
}