variable "vpc_id" {
  type = string
}
variable "cidr_block" {
  type = string
}
variable "availability_zone" {
  type = string
}
variable "tags" {
  type = map(string)
}
variable "name" {
  type = string
}

resource "aws_subnet" "this" {
  vpc_id            = var.vpc_id
  cidr_block        = var.cidr_block
  availability_zone = var.availability_zone
  tags              = merge(var.tags, { Name = var.name })
}

output "subnet_id" {
  value = aws_subnet.this.id
}
