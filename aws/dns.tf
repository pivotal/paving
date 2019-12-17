data "aws_route53_zone" "hosted-zone" {
  name = var.hosted_zone
}

resource "aws_route53_record" "wildcard-sys" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = "*.sys.${var.environment_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = aws_lb.web.dns_name
    zone_id                = aws_lb.web.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wildcard-apps" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = "*.apps.${var.environment_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = aws_lb.web.dns_name
    zone_id                = aws_lb.web.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ssh" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = "ssh.sys.${var.environment_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = aws_lb.ssh.dns_name
    zone_id                = aws_lb.ssh.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "tcp" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = "tcp.${var.environment_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = aws_lb.tcp.dns_name
    zone_id                = aws_lb.tcp.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "pks-api" {
  zone_id = data.aws_route53_zone.hosted-zone.zone_id
  name    = "api.pks.${var.environment_name}.${var.dns_suffix}"
  type    = "A"

  alias {
    name                   = aws_lb.pks-api.dns_name
    zone_id                = aws_lb.pks-api.zone_id
    evaluate_target_health = true
  }
}
