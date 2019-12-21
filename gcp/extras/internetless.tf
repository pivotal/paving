# The internetless template denies egress traffic from
# all platform VMs in the network. It only allows egress
# traffic from the Ops Manager and BOSH Director.

resource "google_compute_firewall" "platform-deny-external-egress" {
  name    = "${var.environment_name}-platform-deny-external-egress"
  network = google_compute_network.network.name

  priority = 1200

  direction = "EGRESS"

  deny {
    protocol = "icmp"
  }

  deny {
    protocol = "tcp"
  }

  deny {
    protocol = "udp"
  }

  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "ops-manager-allow-external-egress" {
  name    = "${var.environment_name}-ops-manager-allow-external-egress"
  network = google_compute_network.network.name

  priority = 1100

  direction = "EGRESS"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  target_service_accounts = [google_service_account.ops-manager.email]

  destination_ranges = ["0.0.0.0/0"]
}
