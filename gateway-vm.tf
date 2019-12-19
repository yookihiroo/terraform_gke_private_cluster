resource "google_compute_instance" "gateway" {
  name         = "${var.gateway.name}-gateway"
  machine_type = var.gateway.machine_type
  zone         = "${var.region}-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    network    = google_compute_network.network.self_link
    subnetwork = google_compute_subnetwork.subnetwork.self_link

    access_config {
    }
  }

  scheduling {
    preemptible       = true
    automatic_restart = false
  }

  metadata_startup_script = "apt-get install kubectl"
}
