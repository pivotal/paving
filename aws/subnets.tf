resource "aws_subnet" "public-subnet" {
  count = length(var.public_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    { Name = "${var.environment_name}-public-subnet-${count.index}" },
  )
}

resource "aws_subnet" "management-subnet" {
  count = length(var.management_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.management_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    { Name = "${var.environment_name}-management-subnet-${count.index}" }
  )
}

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

resource "aws_subnet" "services-subnet" {
  count = length(var.services_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.services_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    { Name = "${var.environment_name}-services-subnet-${count.index}" },
  )
}

resource "aws_subnet" "pks-subnet" {
  count = length(var.pks_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(var.pks_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = merge(
    var.tags,
    { Name = "${var.environment_name}-pks-subnet-${count.index}" },
  )
}
