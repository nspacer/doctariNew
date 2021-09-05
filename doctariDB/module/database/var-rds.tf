variable "vpc_id" {
  type = string
}
variable "database-subnet-ids" {
  type = list(string)
  default = ["subnet-0241b46345dd337f5", "subnet-0b3241536ca538e4a"]
}

variable "database-security-group" {
  type = string
  default = "sg-0b4907c0823cadfb6"
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
  type    = string
}

variable "database_master_password" {
  type    = string
}