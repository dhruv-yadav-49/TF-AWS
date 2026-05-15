terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket = "my-tf-bucket-0da212c3"
    key = "backend.tfstate"
    region = "eu-north-1"
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "myserver" {
  ami = "ami-080254318c2d8932f"
  instance_type = "t3.micro"

  tags = {
    Name = "SampleServer"
  }
}

