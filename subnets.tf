# private subnet
resource "aws_subnet" "marck-pri-sn" {
  count             = length(var.marck_private_subnet)
  vpc_id            = aws_vpc.marck-vpc.id
  cidr_block        = var.marck_private_subnet[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "marck-pri-subnet-${count.index + 1}"
  }
}


# public subnet

resource "aws_subnet" "marck_public" {
  count                   = length(var.marck_public_subnet)
  vpc_id                  = aws_vpc.marck-vpc.id
  cidr_block              = var.marck_public_subnet[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}
