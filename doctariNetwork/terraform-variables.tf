variable "tags" {
  type = map(string)
  default = {
    Name = "myVPC"
  }
}
variable "vpc_name" {
  default = "myVPC"
}