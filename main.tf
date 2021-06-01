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
  bucket = "bucket-with-site"
  acl    = "public-read"

  website {
    index_document = "index.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "docs/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "documents/"
    }
}]
EOF
  }
}

resource "aws_s3_bucket_object" "index" {
  bucket = aws_s3_bucket.b.id
  key    = "index.html"
  source = "index.html"
  acl = "public-read"
  content_type = "text/html"
}