resource "yandex_storage_object" "picture" {
  bucket = "diplom-bucket"
  key    = "gosling.jpg"
  source = "./img/gosling.jpg"
  tags = {
    test = "value"
  }
}

resource "yandex_vpc_network" "diplom-network" {
  name = local.network_name
}

resource "yandex_vpc_subnet" "public-a" {
  name           = local.subnet_name_a
  zone           = var.default_zone_a
  network_id     = yandex_vpc_network.diplom-network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

resource "yandex_vpc_subnet" "public-b" {
  name           = local.subnet_name_b
  zone           = var.default_zone_b
  network_id     = yandex_vpc_network.diplom-network.id
  v4_cidr_blocks = ["192.168.20.0/24"]
}

resource "yandex_vpc_subnet" "public-c" {
  name           = local.subnet_name_c
  zone           = var.default_zone_c
  network_id     = yandex_vpc_network.diplom-network.id
  v4_cidr_blocks = ["192.168.30.0/24"]
}

