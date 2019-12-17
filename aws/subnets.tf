locals {
  public_subnet_cidrs     = ["10.0.0.0/24", "10.0.1.0/24"]
  management_subnet_cidrs = ["10.0.16.0/28", "10.0.16.16/28"]
  pas_subnet_cidrs        = ["10.0.4.0/24", "10.0.5.0/24"]
  services_subnet_cidrs   = ["10.0.8.0/24", "10.0.9.0/24"]
  rds_subnet_cidrs        = ["10.0.12.0/24", "10.0.13.0/24"]
  pks_subnet_cidrs        = ["10.0.14.0/24", "10.0.15.0/24"]
}

resource "aws_subnet" "public-subnet" {
  count = length(local.public_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.public_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment_name}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "management-subnet" {
  count = length(local.management_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.management_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment_name}-management-subnet-${count.index}"
  }
}

resource "aws_subnet" "pas-subnet" {
  count = length(local.pas_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.pas_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment_name}-pas-subnet-${count.index}"
  }
}

resource "aws_subnet" "services-subnet" {
  count = length(local.services_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.services_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment_name}-services-subnet-${count.index}"
  }
}

resource "aws_subnet" "rds-subnet" {
  count = length(local.rds_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.rds_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment_name}-rds-subnet-${count.index}"
  }
}

resource "aws_subnet" "pks-subnet" {
  count = length(local.pks_subnet_cidrs)

  vpc_id            = aws_vpc.vpc.id
  cidr_block        = element(local.pks_subnet_cidrs, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "${var.environment_name}-pks-subnet-${count.index}"
  }
}
