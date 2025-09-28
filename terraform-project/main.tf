terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# resource "random_id" "rand" {
#   byte_length = 4
# }

locals {
  project     = "dt-sec"
  environment = var.environment
  region_code = replace(var.aws_region, "-", "")
  # unique_id   = random_id.rand.hex

  name_prefix = "${local.project}-${local.region_code}-${local.environment}"

  tags = {
    Project     = local.project
    Environment = var.environment
    Region      = var.aws_region
  }
}

# VPC
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = var.cidr_block
  name       = "${local.name_prefix}-vpc"
  tags       = local.tags
}

# Subnet
module "subnet" {
  source            = "./modules/subnet"
  vpc_id            = module.vpc.vpc_id
  cidr_block        = var.public_subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  name              = "${local.name_prefix}-subnet-public"
  tags              = local.tags
}

# Security Group
module "sg" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
  name          = "${local.name_prefix}-sg-web"
  tags          = local.tags
}

# S3
module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_name
  tags        = local.tags
}

# Data sources
data "aws_availability_zones" "available" {}

# EC2
# module "ec2" {
#   source        = "./modules/ec2"
#   ami           = "ami-0a716d3f3b16d290c"
#   instance_type = var.instance_type
#   subnet_id     = module.subnet.subnet_id
#   sg_ids        = [module.sg.sg_id]
#   name          = "${local.name_prefix}-ec2-web"
#   tags          = local.tags
# }

resource "aws_instance" "example" {
  ami           = "ami-0a716d3f3b16d290c"
  instance_type = "t3.micro"

  tags = local.tags
}