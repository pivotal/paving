data "google_dns_managed_zone" "hosted-zone" {
  name = var.hosted_zone
}

resource "google_dns_record_set" "wildcard-sys" {
  name = "*.sys.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_global_address.http-lb.address]
}

resource "google_dns_record_set" "wildcard-apps" {
  name = "*.apps.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_global_address.http-lb.address]
}

resource "google_dns_record_set" "wildcard-websocket" {
  name = "*.ws.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.websocket-lb.address]
}

resource "google_dns_record_set" "doppler-sys" {
  name = "doppler.sys.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.websocket-lb.address]
}

resource "google_dns_record_set" "loggregator-sys" {
  name = "loggregator.sys.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.websocket-lb.address]
}

resource "google_dns_record_set" "ssh" {
  name = "ssh.sys.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.ssh-lb.address]
}

resource "google_dns_record_set" "tcp" {
  name = "tcp.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.tcp-lb.address]
}

resource "google_dns_record_set" "ops-manager" {
  name = "opsmanager.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.ops-manager.address]
}

resource "google_dns_record_set" "pks-api" {
  name = "*.pks.${var.environment_name}.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.pks-api-lb.address]
}

