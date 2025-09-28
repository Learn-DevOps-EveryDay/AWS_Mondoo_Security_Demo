variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}
variable "subnet_id" {
  type = string
}
variable "sg_ids" {
  type = list(string)
}
variable "tags" {
  type = map(string)
}
variable "name" {
  type = string
}

resource "aws_instance" "this" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.sg_ids
  tags                   = merge(var.tags, { Name = var.name })
}

output "instance_id" {
  value = aws_instance.this.id
}
