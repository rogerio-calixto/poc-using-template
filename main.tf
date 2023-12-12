terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.8.0"
    }
  }

  backend "s3" {}
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Project   = "Terraform RPC setup"
      CreatedAt = "2023-12-12"
      ManagedBy = "Terraform"
      Owner     = "Rogerio Calixto"
    }
  }
}