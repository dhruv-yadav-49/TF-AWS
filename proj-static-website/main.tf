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
  byte_length = 8
}

resource "aws_s3_bucket" "webmyapp-bucket" {
  bucket = "webmyapp-bucket-${random_id.bucket_suffix.hex}"

  # tags = {
  #   Name = "MyBucket"
  # }
}



resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.webmyapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
    bucket = aws_s3_bucket.webmyapp-bucket.id
    policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
         Sid = "AddCannedAcl",
         Effect = "Allow",
         Principal = "*",
         Action ="s3:GetObject",
        Resource = "arn:aws:s3:::${aws_s3_bucket.webmyapp-bucket.id}/*"
        }
      ]
    })
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.webmyapp-bucket.id

  index_document {
    suffix = "index.html"
  }

}


resource "aws_s3_object" "index_html" {
  bucket       = aws_s3_bucket.webmyapp-bucket.bucket
  source       = "./index.html"
  key          = "index.html"
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket       = aws_s3_bucket.webmyapp-bucket.bucket
  source       = "./styles.css"
  content_type = "text/css"
  key          = "styles.css"
}

output "bucket_name" {
  value = random_id.bucket_suffix.hex
}