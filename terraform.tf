terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket  = "kar-terraform-apps-state"
    key     = "tf-elk-learning-state/terraform.tfstate"
    region  = "ap-south-1"
    encrypt = true

  }
}

provider "aws" {
  default_tags {
    tags = {
      created-by = "terraform-user"
      app        = "tf-elk-app"
    }
  }
}