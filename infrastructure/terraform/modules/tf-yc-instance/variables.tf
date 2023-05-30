variable "subnet_ids" {
  description = "Datasource object with IDs of the subnets to attach this interface to"
}
variable "disk_size" {
  description = "Size of disk in GB"
  type        = number
  default     = 30
}
variable "image_id" {
  description = "A disk image to initialize this disk from"
  type        = string
  default     = "fd80qm01ah03dkqb14lc"
}
variable "memory" {
  description = "Memory size on GB"
  type        = number
  default     = 2
}
variable "cores" {
  description = "CPU cores for the instance"
  type        = number
  default     = 2
}
variable "platform_id" {
  description = "The type of virtual machine to created"
  type        = string
  default     = "standard-v1"
}
variable "zone" {
  description = "The availability zone where the instance will be created"
  type        = string
  default     = "ru-central1-a"
}
variable "scheduling_policy" {
  description = "Scheduling policy configuration"
  type        = string
  default     = "false"
}
variable "name" {
  description = "Name of the instance to be created"
  type        = string
  default     = "chapter5-lesson2-avoronin"
}