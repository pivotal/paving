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
