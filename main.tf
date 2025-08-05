provider "aws" {
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  endpoints {
    s3 = "http://localhost:4566"
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