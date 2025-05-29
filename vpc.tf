resource "aws_vpc" "marck-vpc" {
  cidr_block           = var.marck_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "marck-vpc"
  }
}
