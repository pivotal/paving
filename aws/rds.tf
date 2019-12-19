resource "aws_subnet" "rds_subnets" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(local.rds_cidr, 2, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    "Name" = "${var.environment_name}-rds-subnet-${count.index}"
  }
}

resource "aws_db_subnet_group" "rds" {
  name        = "${var.environment_name}-rds-subnet-group"
  description = "RDS Subnet Group"

  subnet_ids = aws_subnet.rds.id

  tags = {
    "Name" = "${var.environment_name}-db-subnet-group"
  }
}

resource "random_string" "rds_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "rds" {
  allocated_storage       = 100
  instance_class          = "db.m4.large"
  engine                  = "mariadb"
  engine_version          = "10.1.31"
  identifier              = var.environment_name
  username                = "admin"
  password                = random_string.rds_password.result
  db_subnet_group_name    = aws_db_subnet_group.rds[0].name
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.rds[0].id]
  iops                    = 1000
  multi_az                = true
  skip_final_snapshot     = true
  backup_retention_period = 7
  apply_immediately       = true

  tags = {
    "Name" = "${var.environment_name}-rds"
  }
}

