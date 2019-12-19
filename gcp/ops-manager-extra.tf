resource "google_compute_image" "ops-manager" {
  name = "${var.environment_name}-ops-manager"

  timeouts {
    create = "20m"
  }

  raw_disk {
    source = "https://storage.googleapis.com/ops-manager-us/pcf-gcp-2.8.0-build.187.tar.gz"
  }
}

resource "google_compute_instance" "ops-manager" {
  name         = "${var.environment_name}-ops-manager"
  machine_type = "n1-standard-2"
  zone         = element(var.availability_zones, 1)
  tags         = ["${var.environment_name}-ops-manager"]

  allow_stopping_for_update = true

  timeouts {
    create = "10m"
  }

  boot_disk {
    initialize_params {
      image = google_compute_image.ops-manager.self_link
      type  = "pd-ssd"
      size  = 150
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.infrastructure.self_link

    access_config {
      nat_ip = google_compute_address.ops-manager.address
    }
  }

  service_account {
    email  = google_service_account.ops-manager.email
    scopes = ["cloud-platform"]
  }

  metadata = {
    ssh-keys               = format("ubuntu:%s", tls_private_key.ops-manager.public_key_openssh)
    block-project-ssh-keys = "TRUE"
  }
}

