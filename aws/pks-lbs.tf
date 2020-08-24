# PKS API Load Balancer

resource "aws_lb" "pks-api" {
  name                             = "${var.environment_name}-pks-api"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true
  internal                         = false
  subnets                          = aws_subnet.public-subnet[*].id
}

resource "aws_lb_listener" "pks-api-9021" {
  load_balancer_arn = aws_lb.pks-api.arn
  port              = 9021
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pks-api-9021.arn
  }
}

resource "aws_lb_target_group" "pks-api-9021" {
  name     = "${var.environment_name}-pks-tg-9021"
  port     = 9021
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    healthy_threshold   = 6
    unhealthy_threshold = 6
    interval            = 10
    protocol            = "TCP"
  }
}

resource "aws_lb_listener" "pks-api-8443" {
  load_balancer_arn = aws_lb.pks-api.arn
  port              = 8443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.pks-api-8443.arn
  }
}

resource "aws_lb_target_group" "pks-api-8443" {
  name     = "${var.environment_name}-pks-tg-8443"
  port     = 8443
  protocol = "TCP"
  vpc_id   = aws_vpc.vpc.id
}
