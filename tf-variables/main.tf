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

# Fetch Latest Amazon Linux AMI
data "aws_ami" "amazon_linux" {
    most_recent = true
    owners      = ["amazon"]

    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*"]
    }
}

# Create EC2 Instance
resource "aws_instance" "myserver" {

    ami           = data.aws_ami.amazon_linux.id

    # Variable used here
    instance_type = var.aws_instance_type

    # Root Volume Configuration
    root_block_device {
        volume_size = var.ec2_config.v_size
        volume_type = var.ec2_config.v_type
    }

    # Merge default + additional tags
    tags = merge(
        {
        Name = "SampleServer"
        },
        var.additional_tags
    )
}

# Outputs
output "instance_id" {
    value = aws_instance.myserver.id
}

output "public_ip" {
    value = aws_instance.myserver.public_ip
}