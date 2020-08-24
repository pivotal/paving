resource "google_dns_record_set" "pks-api" {
  name = "*.pks.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.pks-api-lb.address]
}
