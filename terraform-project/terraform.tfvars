aws_region = "eu-north-1"
environment = "dev"

# VPC & Subnet
cidr_block        = "10.0.0.0/16"
public_subnet_cidr = "10.0.1.0/24"

# EC2
instance_type = "t3.micro"

# Security Group Rules
ingress_rules = [
  {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # SSH
  },
  {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # HTTP
  }
]

egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all outbound
  }
]
