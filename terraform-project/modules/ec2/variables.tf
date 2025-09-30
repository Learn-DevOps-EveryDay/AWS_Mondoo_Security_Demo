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