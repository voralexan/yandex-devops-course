output "subnets" {
  description = "Yandex.Cloud Subnets map"
  value       = data.yandex_vpc_subnet.vpc_subnet
}