module "tf-yc-instance" {
  source     = "./modules/tf-yc-instance"
  image_id   = "fd80qm01ah03dkqb14lc"
  zone       = "ru-central1-a"
  subnet_ids = module.tf-yc-network.subnets
}
module "tf-yc-network" {
  source        = "./modules/tf-yc-network"
  network_zones = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
}

output "internal_ip_address" {
  description = "Internal IP of the created instance"
  value       = module.tf-yc-instance.internal_ip_address
}

output "external_ip_address" {
  description = "External IP of the created instance"
  value       = module.tf-yc-instance.external_ip_address
}