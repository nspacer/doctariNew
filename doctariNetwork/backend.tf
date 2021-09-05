terraform {
  backend "s3" {
    bucket = "terraform.tfstate.efgh"
    key    = "terraform/tfstate"
    region = "eu-central-1"
  }
}