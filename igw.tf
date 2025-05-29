resource "aws_internet_gateway" "marck-tf-igw" {
  vpc_id = aws_vpc.marck-vpc.id

  tags = {
    Name = "marck-igw"
  }
}
