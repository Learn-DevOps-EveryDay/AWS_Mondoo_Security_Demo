variable "cidr_block" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "name" {
  type = string
}

resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags       = merge(var.tags, { Name = var.name })
}

output "vpc_id" {
  value = aws_vpc.this.id
}
