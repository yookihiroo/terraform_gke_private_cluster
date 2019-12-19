# ファイアウォール設定
resource "google_compute_firewall" "firewall-icmp" {
  name        = "${var.firewall.icmp.name}-icmp-firewall"
  network     = google_compute_network.network.self_link
  priority    = 65534
  direction   = "INGRESS"
  description = var.version_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]
}

resource "google_compute_firewall" "firewall-internal" {
  name        = "${var.firewall.internal.name}-internal-firewall"
  network     = google_compute_network.network.self_link
  priority    = 65534
  direction   = "INGRESS"
  description = var.version_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]
}
