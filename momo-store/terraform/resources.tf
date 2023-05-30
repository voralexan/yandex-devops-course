resource "yandex_vpc_network" "network" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

module "kube" {
  source     = "github.com/terraform-yc-modules/terraform-yc-kubernetes"
  network_id = yandex_vpc_network.network.id

  master_locations   = [
    {
      zone      = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet.id
    }
  ]

  master_maintenance_windows = [
    {
      day        = "monday"
      start_time = "23:00"
      duration   = "3h"
    }
  ]

  node_groups = {
    "yc-k8s-ng-01" = {
      description  = "Kubernetes nodes group 01"
      fixed_scale   = {
        size = 1
      }
      node_labels   = {
        role        = "worker-01"
        environment = "prod"
      }
    }
  }
}