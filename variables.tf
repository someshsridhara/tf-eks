variable "aws_region" {
  default = "ap-southeast-2"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name."
  default = "tf-sample-cluster"
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version."
  default = "1.18"
}

variable "prefix_name" {
  type        = string
  description = "Prefix to be used on each infrastructure object Name created in AWS."
  default = "sample"
}

variable "env_tag" {
  type        = string
  description = "Tag to indicate env name."
  default = "development"
}

# VPC Variables

variable "network_block" {
  type        = string
  description = "Base CIDR block to be used in our VPC."
  default = "10.0.0.0/16"
}

# EKS Variables

variable "admin_users" {
  type        = list(string)
  description = "List of Kubernetes admins."
  default = ["Somesha"]
}

variable "asg_instance_types" {
  type        = list(string)
  description = "List of EC2 instance machine types to be used in EKS."
  default = ["t3.micro", "t2.micro"]
}

variable "autoscaling_minimum_size_by_az" {
  type        = number
  description = "Minimum number of EC2 instances to autoscale our EKS cluster on each AZ."
  default = 2
}

variable "autoscaling_maximum_size_by_az" {
  type        = number
  description = "Maximum number of EC2 instances to autoscale our EKS cluster on each AZ."
  default = 10
}

variable "autoscaling_average_cpu" {
  type        = number
  description = "Average CPU threshold to autoscale EKS EC2 instances."
  default = 30
}

variable "spot_termination_handler_chart_name" {
  type        = string
  description = "EKS Spot termination handler Helm chart name."
  default = "aws-node-termination-handler"
}

variable "spot_termination_handler_chart_repo" {
  type        = string
  description = "EKS Spot termination handler Helm repository name."
  default = "https://aws.github.io/eks-charts"
}

variable "spot_termination_handler_chart_version" {
  type        = string
  description = "EKS Spot termination handler Helm chart version."
  default = "0.13.3"
}

variable "spot_termination_handler_chart_namespace" {
  type        = string
  description = "Kubernetes namespace to deploy EKS Spot termination handler Helm chart."
  default = "kube-system"
}

# DNS
variable "dns_base_domain" {
  type        = string
  description = "DNS Zone name to be used from EKS Ingress."
  default = "someshasridhara.com"
}
