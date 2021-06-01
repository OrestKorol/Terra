terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "3.42.0"
    }
  }
}

provider "aws" {
  profile = "terraform"
  region = "us-west-2"
}

resource "aws_s3_bucket" "b" {
  bucket = "terraform-test-practice"
  acl    = "public-read"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}