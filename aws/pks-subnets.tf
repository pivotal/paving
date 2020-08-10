resource "aws_subnet" "pks-subnet" {
  count = length(var.pks_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.pks_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
  var.tags,
  { Name = "${var.environment_name}-pks-subnet-${count.index}" },
  { "kubernetes.io/role/internal-elb" = "1" }
  )
}
