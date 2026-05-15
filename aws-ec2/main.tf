terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
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

