# Fetch available AZs
data "aws_availability_zones" "available_azs" {
  state = "available"
}

# Elastic IP for the NAT gateway
resource "aws_eip" "nat_gw_elastic_ip" {
  vpc = true

  tags = {
    Name            = "${var.cluster_name}-nat-eip"
    env = var.env_tag
  }
}

# VPC creation with AWS VPC module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.66.0"

  name = "${var.prefix_name}-vpc"
  cidr = var.network_block
  azs  = data.aws_availability_zones.available_azs.names

  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  # For this demo, we can use just one NAT gateway in one AZ, save costs.
  one_nat_gateway_per_az = false
  enable_dns_hostnames   = true
  reuse_nat_ips          = true
  external_nat_ip_ids    = [aws_eip.nat_gw_elastic_ip.id]

  # Add tags for EKS
  tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    env                             = var.env_tag
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                    = "1"
    env                             = var.env_tag
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"           = "1"
    env                             = var.env_tag
  }
}