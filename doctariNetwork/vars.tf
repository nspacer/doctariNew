variable "AWS_REGION" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_ACCESS_KEY" {}
variable "AMIS" {
  type = map(string)
  default = {
    "eu-central-1" = "ami-02f9ea74050d6f812"
    "eu-west-1"    = "ami-096f43ef67d75e998"
    "eu-west-2"    = "ami-0ffd774e02309201f"
  }
}
variable "INSTANCE_TYPE" {}

variable "AWS_PUBLIC_KEY" {
  default = "ec2-demo-mac.pem.pub"
}

variable "sgPortsPublic" {
  type    = list(number)
  default = [22, 80]
}
