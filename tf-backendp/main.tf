terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "5.54.1"
        }
    }
    backend "s3" {
        bucket = "dmo-buket-bab1fa1d0a334e85"
        key    = "backend.tfstate"
        region = "eu-north-1"
      
    }
} 

provider "aws" {
    region = "eu-north-1"
}

resource "aws_instance" "myec2" {
    ami = "ami-0b5a4e51202cd98e5"
    instance_type = "t3.micro"

    tags = {
        Name = "SampleServerrrr"
    }
}