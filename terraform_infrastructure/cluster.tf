data "yandex_compute_image" "ubuntu" {
  image_id = "fd8chrq89mmk8tqm85r8"
}

resource "yandex_compute_instance" "nat-instance" {
  count = 3
  name        = "vm-${count.index+1}"
  platform_id = "standard-v3"
  zone        = var.default_zone_b

  resources {
    core_fraction = var.vm_resources.nat_res.core_fraction
    cores         = var.vm_resources.nat_res.cores
    memory        = var.vm_resources.nat_res.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_resources.nat_res.disk_size
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    index     = 1
    subnet_id = yandex_vpc_subnet.public-b.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.yml")}"
    serial-port-enable = "1"
  }
}
