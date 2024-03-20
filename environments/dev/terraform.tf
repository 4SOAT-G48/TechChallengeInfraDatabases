terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.41.0"
    }
  }
  backend "s3" {
    bucket  = "terraform-fiap-4soat-g48-acafl"
    key     = "dev/database"
    region  = "us-east-1"
    profile = "4soat_g48"
  }
}