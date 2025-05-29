# Public route table
resource "aws_route_table" "marck-pub-rt" {
  vpc_id = aws_vpc.marck-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.marck-tf-igw.id
  }

  tags = {
    Name = "marck-public-rt"
  }
}

resource "aws_route_table_association" "marck-tf-pub-rta" {
  count          = length(var.marck_public_subnet)
  subnet_id      = aws_subnet.marck_public[0].id
  route_table_id = aws_route_table.marck-pub-rt.id
}

# Private route table
resource "aws_route_table" "marck-pri-rt" {
  vpc_id = aws_vpc.marck-vpc.id

  tags = {
    Name = "marck-private-rt"
  }
}

resource "aws_route_table_association" "marck-tf-pri-rta" {
  count          = length(var.marck_private_subnet)
  subnet_id      = aws_subnet.marck-pri-sn[0].id
  route_table_id = aws_route_table.marck-pri-rt.id
}
