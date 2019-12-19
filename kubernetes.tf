# Kubernetesクラスタ設定
resource "google_container_cluster" "cluster" {
  name        = "${var.cluster.name}-cluster"
  location    = var.region
  network     = google_compute_network.network.self_link
  subnetwork  = google_compute_subnetwork.subnetwork.self_link
  description = var.version_name

  node_version       = var.cluster.node_version
  min_master_version = var.cluster.min_master_version

  remove_default_node_pool = true
  initial_node_count       = 1

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    # 現状、クラスタマスタへのIP制限をしていない（必要に応じて修正する）
    cidr_blocks {
      display_name = "allow_all"
      cidr_block   = "0.0.0.0/0"
    }
  }


  ip_allocation_policy {
  }

  lifecycle {
    ignore_changes = [
      node_pool
    ]
  }
}

resource "google_container_node_pool" "node_pool" {
  name       = "${var.node_pool.name}-node-pool"
  location   = var.region
  cluster    = google_container_cluster.cluster.name
  node_count = var.node_pool.count

  node_config {
    # プリエンプティブルノードにするか？
    preemptible = var.node_pool.is_preemptible

    machine_type = var.node_pool.machine_type
    disk_size_gb = var.node_pool.disk_size_gb

    oauth_scopes = [
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
}
