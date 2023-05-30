output "internal_ip_address" {
  description = "Internal IP of the created instance"
  value       = yandex_compute_instance.vm-1.network_interface.0.ip_address
}
output "external_ip_address" {
  description = "External IP of the created instance"
  value       = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
}