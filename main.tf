provider "aws" {
  region = "ap-northeast-2"
}


terraform {
  backend "s3" {
    bucket = "example-terraform"
    key    = "state/terraform.tfstate"
    region = "ap-northeast-2"
  }
}