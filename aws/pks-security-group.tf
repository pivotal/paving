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
