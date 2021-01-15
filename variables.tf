terraform {
  backend "s3" {
    bucket = "tf-infra-demo"
    key = "tf-state.json"
    region = "ap-southeast-2"
    workspace_key_prefix = "env"
  }
}

variable "aws_region" {
  default = "ap-southeast-2"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
  default = "tf-worksample-cluster"
}

variable "prefix_name" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
  default = "worksample"
}

variable "env_tag" {
  type        = string
  description = "Tag to indicate env name."
  default = "dev"
}

# VPC Variables

variable "network_block" {
  type        = string
  description = "Base CIDR block to be used in our VPC."
  default = "10.0.0.0/16"
}

# EKS Variables

