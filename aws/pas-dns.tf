resource "aws_route53_record" "wildcard-sys" {
  provider = aws.public-dns

  name = "*.sys.${var.environment_name}.${data.aws_route53_zone.hosted.name}"

  zone_id = data.aws_route53_zone.hosted.zone_id
  type    = "A"

  alias {
    name                   = aws_lb.web.dns_name
    zone_id                = aws_lb.web.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "wildcard-apps" {
  provider = aws.public-dns

  name = "*.apps.${var.environment_name}.${data.aws_route53_zone.hosted.name}"

  zone_id = data.aws_route53_zone.hosted.zone_id
  type    = "A"

  alias {
    name                   = aws_lb.web.dns_name
    zone_id                = aws_lb.web.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "ssh" {
  provider = aws.public-dns

  name = "ssh.sys.${var.environment_name}.${data.aws_route53_zone.hosted.name}"

  zone_id = data.aws_route53_zone.hosted.zone_id
  type    = "A"

  alias {
    name                   = aws_lb.ssh.dns_name
    zone_id                = aws_lb.ssh.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "tcp" {
  provider = aws.public-dns

  name = "tcp.${var.environment_name}.${data.aws_route53_zone.hosted.name}"

  zone_id = data.aws_route53_zone.hosted.zone_id
  type    = "A"

  alias {
    name                   = aws_lb.tcp.dns_name
    zone_id                = aws_lb.tcp.zone_id
    evaluate_target_health = true
  }
}
