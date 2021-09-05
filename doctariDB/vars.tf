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

variable "database-instance-class" {
  type    = string
  default = "db.t2.micro"
}

variable "database-instance-identifier" {
  type    = string
  default = "mysql57db"
}

variable "multi-az-deployment" {
  type    = bool
  default = false
}


variable "database-user-name" {
  type = string
  default = ""
}

variable "database_master_password" {
  type = string
  default = ""
}

variable "database-security-group" {
  type = string
  default = ""
}

variable "database-subnet-ids" {
  type = list(string)
  default = [""]
}

variable "vpc_id" {
  type = string
  default = ""
}
