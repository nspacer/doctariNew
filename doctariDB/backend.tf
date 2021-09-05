terraform {
  backend "s3" {
    bucket = "terraform.tfstate.xyz.db"
    key    = "terraform/tfstate"
    region = "eu-central-1"
  }
}