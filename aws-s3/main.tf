terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "random_id" "bucket_suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "name" {
  bucket = "my-tf-bucket-${random_id.bucket_suffix.hex}"

  # tags = {
  #   Name = "MyBucket"
  # }
}

# resource "aws_s3_object" "bucket-data" {
#   bucket = aws_s3_bucket.demo-bucket.bucket
#   key    = "demo/test.txt"
# }

output "bucket_name" {
  value = aws_s3_bucket.name.bucket
}