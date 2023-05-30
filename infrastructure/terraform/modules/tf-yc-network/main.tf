data "yandex_vpc_network" "vpc_network" {
  name = "default"
}

data "yandex_vpc_subnet" "vpc_subnet" {
  for_each = var.network_zones
  name     = "${data.yandex_vpc_network.vpc_network.name}-${each.key}"
}