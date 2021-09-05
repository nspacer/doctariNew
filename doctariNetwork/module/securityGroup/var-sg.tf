variable "vpc_id" {
  type = string
}

variable "sgPortsPublic" {
  type    = list(number)
  default = [22, 80]
}