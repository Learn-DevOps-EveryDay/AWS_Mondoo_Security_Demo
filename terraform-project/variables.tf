variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { 
      from_port = 22, 
      to_port = 22, 
      protocol = "tcp", 
      cidr_blocks = ["0.0.0.0/0"] 
      },
    { 
        from_port = 80, 
        to_port = 80, 
        protocol = "tcp", 
        cidr_blocks = ["0.0.0.0/0"] 
        }
  ]
}

variable "egress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { 
        from_port = 0, 
        to_port = 0, 
        protocol = "-1", 
        cidr_blocks = ["0.0.0.0/0"] 
        }
  ]
}
