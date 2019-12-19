data "google_dns_managed_zone" "hosted-zone" {
  name = var.hosted_zone
}

resource "google_dns_record_set" "wildcard-sys" {
  name = "*.sys.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_global_address.http-lb.address]
}

resource "google_dns_record_set" "wildcard-apps" {
  name = "*.apps.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_global_address.http-lb.address]
}

resource "google_dns_record_set" "wildcard-ws" {
  name = "*.ws.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.ws-lb.address]
}

resource "google_dns_record_set" "doppler-sys" {
  name = "doppler.sys.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.ws-lb.address]
}

resource "google_dns_record_set" "loggregator-sys" {
  name = "loggregator.sys.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.ws-lb.address]
}

resource "google_dns_record_set" "app-ssh" {
  name = "ssh.sys.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.ssh-lb.address]
}

resource "google_dns_record_set" "tcp" {
  name = "tcp.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.tcp-lb.address]
}

resource "google_dns_record_set" "ops-manager" {
  name = "opsman.${data.google_dns_managed_zone.hosted-zone.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = var.hosted_zone

  rrdatas = [google_compute_address.ops-manager.address]
}
