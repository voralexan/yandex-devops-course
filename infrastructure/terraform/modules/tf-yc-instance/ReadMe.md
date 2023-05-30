# A module to create YC instance
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.5 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | ~> 0.82.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | ~> 0.82.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_compute_instance.vm-1](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cores"></a> [cores](#input\_cores) | CPU cores for the instance | `number` | `2` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Size of disk in GB | `number` | `30` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | A disk image to initialize this disk from | `string` | `"fd80qm01ah03dkqb14lc"` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory size on GB | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the instance to be created | `string` | `"chapter5-lesson2-avoronin"` | no |
| <a name="input_platform_id"></a> [platform\_id](#input\_platform\_id) | The type of virtual machine to created | `string` | `"standard-v1"` | no |
| <a name="input_scheduling_policy"></a> [scheduling\_policy](#input\_scheduling\_policy) | Scheduling policy configuration | `string` | `"false"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Datasource object with IDs of the subnets to attach this interface to | `any` | n/a | yes |
| <a name="input_zone"></a> [zone](#input\_zone) | The availability zone where the instance will be created | `string` | `"ru-central1-a"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_external_ip_address"></a> [external\_ip\_address](#output\_external\_ip\_address) | External IP of the created instance |
| <a name="output_internal_ip_address"></a> [internal\_ip\_address](#output\_internal\_ip\_address) | Internal IP of the created instance |
<!-- END_TF_DOCS -->