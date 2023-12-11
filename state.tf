terraform {
  backend "s3" {}
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.8.0"
    }
  }
}