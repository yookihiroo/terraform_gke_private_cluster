variable "project" {
  description = "プロジェクトID"
#  default     = "my-project"
}

variable "region" {
  description = "リージョン"
#  default     = "us-west1"
}

variable "version_name" {
  description = "リソースのdescriptionなどに入る文字列"
  default     = "テスト用(test1:v0.0.1)"
}

variable "network" {
  description = "ネットワーク"
  type        = map
  default = {
    name = "test1"
  }
}

variable "subnetwork" {
  description = "サブネットワーク"
  type        = map
  default = {
    name          = "test1"
    ip_cidr_range = "10.0.0.0/9"
  }
}

variable "router" {
  description = "ルーター"
  type        = map
  default = {
    name = "test1"
    # Google ASN 64512-65534 を指定する
    asn = 64512
  }
}

variable "nat" {
  description = "NAT"
  type        = map
  default = {
    name = "test1"
  }
}

variable "firewall" {
  description = "firewall設定"
  type        = map
  default = {
    icmp = {
      description = "ICMPを許可するfirewall設定名"
      name        = "test1"
    }
    internal = {
      description = "内部ネットワークで許可する通信のfirewall設定名"
      name        = "test1"
    }
  }
}

variable "cluster" {
  description = "Kubernetesクラスタ"
  type        = map
  default = {
    name                     = "test1"
    cluster_secondary_range  = "test-gke-pods"
    services_secondary_range = "test-gke-services"
    node_version             = "1.13.11-gke.14"
    min_master_version       = "1.13.11-gke.14"

  }
}

variable "node_pool" {
  description = "Kubernetesノードプール"
  type        = map
  default = {
    name           = "test1"
    machine_type   = "n1-standard-1"
    disk_size_gb   = 100
    count          = 1
    is_preemptible = true
  }
}
variable "gateway" {
  description = "踏み台サーバ"
  type        = map
  default = {
    name         = "test1"
    machine_type = "f1-micro"
  }
}
