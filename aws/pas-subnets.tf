resource "aws_subnet" "pas-subnet" {
  count = length(var.pas_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.pas_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
  var.tags,
  { Name = "${var.environment_name}-pas-subnet-${count.index}" },
  )
}
