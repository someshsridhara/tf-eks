
terraform {
  required_version = ">= 0.14"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

data "aws_caller_identity" "current" {}