resource "aws_eip" "nat" {
  vpc = true

  tags = {
    "Name" = "${var.environment_name}-nat-eip"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public-subnet[0].id

  tags = {
    "Name" = "${var.environment_name}-nat-gateway"
  }

  depends_on = [aws_internet_gateway.gw]
}
