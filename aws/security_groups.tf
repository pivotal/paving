resource "aws_security_group" "nat" {
  name   = "${var.environment_name}-nat-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-nat-sg" },
  )
}

resource "aws_security_group" "ops-manager" {
  name   = "${var.environment_name}-ops-manager-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = var.ops_manager_allowed_ips
    protocol    = "tcp"
    from_port   = 22
    to_port     = 22
  }

  ingress {
    cidr_blocks = var.ops_manager_allowed_ips
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  ingress {
    cidr_blocks = var.ops_manager_allowed_ips
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-ops-manager-sg" },
  )
}

resource "aws_security_group" "platform" {
  name   = "${var.environment_name}-platform-vms-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-platform-vms-sg" },
  )
}

resource "aws_security_group" "web-lb" {
  name   = "${var.environment_name}-web-lb-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 443
    to_port     = 443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-web-lb-sg" },
  )
}

resource "aws_security_group" "ssh-lb" {
  name   = "${var.environment_name}-ssh-lb-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 2222
    to_port     = 2222
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-ssh-lb-sg" },
  )
}

resource "aws_security_group" "tcp-lb" {
  name   = "${var.environment_name}-tcp-lb-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 1024
    to_port     = 1034
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-tcp-lb-sg" },
  )
}

resource "aws_security_group" "mysql" {
  name   = "${var.environment_name}-mysql-sg"
  vpc_id = aws_vpc.vpc.id

  ingress {
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    protocol    = "tcp"
    from_port   = 3306
    to_port     = 3306
  }

  egress {
    cidr_blocks = [aws_vpc.vpc.cidr_block]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-mysql-sg" },
  )
}

resource "aws_security_group" "pks-internal-sg" {
  name        = "${var.environment_name}-pks-internal"
  description = "PKS Internal Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    cidr_blocks = concat(var.pks_subnet_cidrs, var.services_subnet_cidrs)
    protocol    = "icmp"
    from_port   = 0
    to_port     = 0
  }

  ingress {
    cidr_blocks = concat(var.pks_subnet_cidrs, var.services_subnet_cidrs)
    protocol    = "tcp"
    from_port   = 0
    to_port     = 0
  }

  ingress {
    cidr_blocks = concat(var.pks_subnet_cidrs, var.services_subnet_cidrs)
    protocol    = "udp"
    from_port   = 0
    to_port     = 0
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-pks-internal" },
  )
}

resource "aws_security_group" "pks-api-lb" {
  name        = "${var.environment_name}-pks-api-lb-sg"
  description = "PKS API LB Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 9021
    to_port     = 9021
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "tcp"
    from_port   = 8443
    to_port     = 8443
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-pks-api-lb-sg" },
  )
}
