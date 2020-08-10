resource "aws_route53_record" "pks-api" {
  name = "api.pks.${var.environment_name}.${data.aws_route53_zone.hosted.name}"

  zone_id = data.aws_route53_zone.hosted.zone_id
  type    = "A"

  alias {
    name                   = aws_lb.pks-api.dns_name
    zone_id                = aws_lb.pks-api.zone_id
    evaluate_target_health = true
  }
}
