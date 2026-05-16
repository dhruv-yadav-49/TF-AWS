terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "5.54.1"
        }
        random = {
            source  = "hashicorp/random"
            version = "3.6.2"
        }
    }
}

provider "aws" {
    region = "eu-north-1"
}

resource "random_id" "rand_id" {
    byte_length = 8
}

resource "aws_s3_bucket" "dmo-buket" {
    bucket = "dmo-buket-${random_id.rand_id.hex}"

    tags = {
        Name = "demo-bucket"
    }
}

resource "aws_s3_object" "bucket-data" {
    bucket = aws_s3_bucket.dmo-buket.bucket
    source = "./myfile.txt"
    key    = "mydata.txt"
}

output "name" {
    value = random_id.rand_id.hex
}


