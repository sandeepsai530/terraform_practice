terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "terraform-eks-state-locks-sai123"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-eks-state-locks-sai123"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
}