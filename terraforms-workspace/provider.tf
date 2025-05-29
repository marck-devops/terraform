terraform {
  backend "s3" {
    bucket = "marck-tf-s3"
    key    = "test/mike/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}
