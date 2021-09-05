variable "region" {
  description = "The AWS region to create things in."
  default     = "eu-central-1"
}

variable "az_count" {
  description = "Number of AZs to cover in a given AWS region"
  default     = "2"
}

variable "cidr_block" {
  description = "The CIDR block the VPC shoud cover"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  type        = string
  description = "The name of the VPC"
  default = "myVPC"
}

variable "tags" {
  type        = map
  description = "A map (key, value) of tags that will be applied to resources in AWS"
}

variable "tag_git_repo_url" {
  type        = string
  description = "The URL of the Git repository"
  default     = ""
}
variable "tag_git_branch" {
  type        = string
  description = "The Git branch"
  default     = ""
}
variable "tag_build_id" {
  type        = string
  description = "The ID of the build"
  default     = ""
}

