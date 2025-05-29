resource "aws_eip" "marck-tf-nat" {
  vpc = true
}

resource "aws_nat_gateway" "marck-tf-pub-nat" {
  allocation_id = aws_eip.marck-tf-nat.id
  subnet_id     = aws_subnet.marck_public[0].id

  tags = {
    Name = "main-nat"
  }

  depends_on = [aws_internet_gateway.marck-tf-igw]
}

resource "aws_route" "marck-tf-pri-nat" {
  route_table_id         = aws_route_table.marck-pri-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.marck-tf-pub-nat.id
}
