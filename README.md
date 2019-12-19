GKE private cluster
===

GKEで、terraformを使用してプライベートクラスタを構築する場合の例

in variables.tf
- project, regionを設定
- 

in kubernetes.tf
- master_authorized_networks_configが設定されていない（全許可）ので、自分のIPをセットするなどする
- 他に設定する場合は、cider_blocksを増やす

- terraform apply
- gcloud container clusters get-credentials test1-cluster --region={var.region} [--internal-ip]
- enjoy!
