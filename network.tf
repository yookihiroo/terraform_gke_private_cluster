# ネットワーク設定
resource "google_compute_network" "network" {
  name                    = "${var.network.name}-net"
  project                 = var.project
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  description             = var.version_name
}

resource "google_compute_subnetwork" "subnetwork" {
  name                     = "${var.subnetwork.name}-subnet"
  region                   = var.region
  network                  = google_compute_network.network.self_link
  private_ip_google_access = true
  ip_cidr_range            = var.subnetwork.ip_cidr_range
}

resource "google_compute_router" "router" {
  name        = "${var.router.name}-router"
  network     = google_compute_network.network.self_link
  region      = var.region
  description = var.version_name

  bgp {
    asn = var.router.asn
  }
}

resource "google_compute_address" "address" {
  name   = "${var.nat.name}-ip"
  region = var.region
}

resource "google_compute_router_nat" "nat" {
  name                               = "${var.nat.name}-nat"
  router                             = google_compute_router.router.name
  region                             = var.region
  nat_ip_allocate_option             = "MANUAL_ONLY"
  nat_ips                            = [google_compute_address.address.self_link]
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
