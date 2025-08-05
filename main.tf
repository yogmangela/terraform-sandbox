provider "aws" {
  region                      = var.region
  access_key                  = "test"
  secret_key                  = "test"
  s3_force_path_style         = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  endpoints {
    s3 = var.endpoint
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "my-localstack-bucket"
}

variable "region" {
  default = "us-east-1"
}

variable "endpoint" {
  default = "http://localhost:4566"
}