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
