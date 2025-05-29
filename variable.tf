variable "aws_region" {
  default = "us-east-1"
  type = string
  description = "Region"
}

variable "marck_cidr" {
  default = "10.0.0.0/16"
  type = string
  description = "CIDR block"
}

variable "marck_public_subnet" {
  default = ["10.0.10.0/24", "10.0.20.0/24"]
  type = list(string)
  description = "Public Subnet"
}

variable "marck_private_subnet" {
  default = ["10.0.30.0/24", "10.0.40.0/24"]
  type = list(string)
  description = "Private Subnet"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1b"]
  type = list(string)
  description = "Zone"
}




