data "aws_route53_zone" "hosted" {
  name = var.hosted_zone
}

resource "aws_route53_record" "ops-manager" {
  name = "opsmanager.${var.environment_name}.${data.aws_route53_zone.hosted.name}"

  zone_id = data.aws_route53_zone.hosted.zone_id
  type    = "A"
  ttl     = 300

  records = [aws_eip.ops-manager.public_ip]
}
