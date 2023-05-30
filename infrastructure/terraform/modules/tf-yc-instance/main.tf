resource "yandex_compute_instance" "vm-1" {

  name        = var.name
  zone        = var.zone
  platform_id = var.platform_id

  scheduling_policy {
    preemptible = var.scheduling_policy
  }

  resources {
    cores  = var.cores
    memory = var.memory
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = var.disk_size
    }
  }

  network_interface {
    subnet_id = var.subnet_ids["${var.zone}"].subnet_id
    nat       = true
  }

  metadata = {
    user-data = "${file("./user-data.yml")}"
  }
}

