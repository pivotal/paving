# Web Load Balancer

resource "aws_lb" "web" {
  name                             = "${var.environment_name}-web-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  subnets                          = aws_subnet.public-subnet[*].id
}

resource "aws_lb_listener" "web-80" {
  load_balancer_arn = aws_lb.web.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-80.arn
  }
}

resource "aws_lb_listener" "web-443" {
  load_balancer_arn = aws_lb.web.arn
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-443.arn
  }
}

resource "aws_lb_target_group" "web-80" {
  name     = "${var.environment_name}-web-tg-80"
  port     = 80
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    protocol = "TCP"
  }
}

resource "aws_lb_target_group" "web-443" {
  name     = "${var.environment_name}-web-tg-443"
  port     = 443
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    protocol = "TCP"
  }
}

# SSH Load Balancer

resource "aws_lb" "ssh" {
  name                             = "${var.environment_name}-ssh-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  subnets                          = aws_subnet.public-subnet[*].id
}

resource "aws_lb_listener" "ssh" {
  load_balancer_arn = aws_lb.ssh.arn
  port              = 2222
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ssh.arn
  }
}

resource "aws_lb_target_group" "ssh" {
  name     = "${var.environment_name}-ssh-tg"
  port     = 2222
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    protocol = "TCP"
  }
}

# TCP Load Balancer

resource "aws_lb" "tcp" {
  name                             = "${var.environment_name}-tcp-lb"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  subnets                          = aws_subnet.public-subnet[*].id
}

locals {
  tcp_port_count = 5
}

resource "aws_lb_listener" "tcp" {
  load_balancer_arn = aws_lb.tcp.arn
  port              = 1024 + count.index
  protocol          = "TCP"

  count = local.tcp_port_count

  default_action {
    type             = "forward"
    target_group_arn = element(aws_lb_target_group.tcp[*].arn, count.index)
  }
}

resource "aws_lb_target_group" "tcp" {
  name     = "${var.environment_name}-tcp-tg-${1024 + count.index}"
  port     = 1024 + count.index
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id

  count = local.tcp_port_count

  health_check {
    protocol = "TCP"
  }
}
