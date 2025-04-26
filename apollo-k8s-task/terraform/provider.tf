terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


# Configure the AWS Provider
# provider "aws" {
#   region  = var.aws_region
#   profile = "default"
# }


# Create a S3 bucket
resource "aws_s3_bucket" "example" {
  bucket = "yogs-tf-test-bucket"

  tags = {
    Name        = "yogs-tf-test-bucket"
    Environment = "Dev"
  }
}