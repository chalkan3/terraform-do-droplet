# DigitalOcean Droplet Terraform Module

This module creates a DigitalOcean droplet with configurable options for networking, security, and monitoring.

## Features

- 🚀 Configurable droplet with smart defaults
- 🔒 Optional firewall with customizable rules
- 📊 Monitoring and backup options
- 🏷️ Automatic tagging for organization
- 🌐 VPC and SSH key support
- 💾 Volume attachment support

## Usage

```hcl
module "droplet" {
  source = "./modules/droplet"

  name        = "web-server"
  region      = "nyc3"
  size        = "s-1vcpu-1gb"
  environment = "production"
  project     = "webapp"

  # Enable firewall with default rules
  create_firewall = true

  # Enable monitoring and backups
  monitoring_enabled = true
  backups_enabled    = true

  tags = ["web", "frontend"]
}
```

## Advanced Usage

```hcl
module "api_server" {
  source = "./modules/droplet"

  name     = "api-server"
  region   = "nyc3"
  size     = "s-2vcpu-4gb"
  image    = "ubuntu-22-04-x64"
  vpc_uuid = var.vpc_id

  # Custom firewall rules
  create_firewall = true
  firewall_inbound_rules = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["10.0.0.0/8"]
    },
    {
      protocol         = "tcp"
      port_range       = "80,443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "8080"
      source_addresses = ["10.0.0.0/8"]
    }
  ]

  # User data script
  user_data = file("${path.module}/user-data.sh")

  environment = "production"
  project     = "api"
  tags        = ["api", "backend", "critical"]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_droplet.this](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/droplet) | resource |
| [digitalocean_firewall.droplet_firewall](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | Name of the droplet | `string` | n/a | yes |
| <a name="input_backups_enabled"></a> [backups\_enabled](#input\_backups\_enabled) | Enable DigitalOcean backups | `bool` | `false` | no |
| <a name="input_create_firewall"></a> [create\_firewall](#input\_create\_firewall) | Whether to create a firewall for this droplet | `bool` | `false` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment name (dev, staging, prod) | `string` | `"dev"` | no |
| <a name="input_firewall_inbound_rules"></a> [firewall\_inbound\_rules](#input\_firewall\_inbound\_rules) | List of inbound firewall rules | `list(object({...}))` | See variables.tf | no |
| <a name="input_firewall_outbound_rules"></a> [firewall\_outbound\_rules](#input\_firewall\_outbound\_rules) | List of outbound firewall rules | `list(object({...}))` | See variables.tf | no |
| <a name="input_graceful_shutdown"></a> [graceful\_shutdown](#input\_graceful\_shutdown) | Enable graceful shutdown | `bool` | `true` | no |
| <a name="input_image"></a> [image](#input\_image) | Droplet image slug or ID | `string` | `"ubuntu-22-04-x64"` | no |
| <a name="input_monitoring_enabled"></a> [monitoring\_enabled](#input\_monitoring\_enabled) | Enable DigitalOcean monitoring | `bool` | `true` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | `"default"` | no |
| <a name="input_region"></a> [region](#input\_region) | DigitalOcean region | `string` | `"nyc3"` | no |
| <a name="input_resize_disk"></a> [resize\_disk](#input\_resize\_disk) | Allow disk resizing when changing droplet size | `bool` | `true` | no |
| <a name="input_size"></a> [size](#input\_size) | Droplet size | `string` | `"s-1vcpu-1gb"` | no |
| <a name="input_ssh_keys"></a> [ssh\_keys](#input\_ssh\_keys) | List of SSH key IDs or fingerprints | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | List of tags to apply to the droplet | `list(string)` | `[]` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | User data script to run on droplet creation | `string` | `null` | no |
| <a name="input_volume_ids"></a> [volume\_ids](#input\_volume\_ids) | List of volume IDs to attach to the droplet | `list(string)` | `[]` | no |
| <a name="input_vpc_uuid"></a> [vpc\_uuid](#input\_vpc\_uuid) | VPC UUID to place the droplet in | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_connection_info"></a> [connection\_info](#output\_connection\_info) | Connection information for SSH |
| <a name="output_disk"></a> [disk](#output\_disk) | The size of the instance's disk in GB |
| <a name="output_firewall_id"></a> [firewall\_id](#output\_firewall\_id) | The ID of the firewall (if created) |
| <a name="output_firewall_name"></a> [firewall\_name](#output\_firewall\_name) | The name of the firewall (if created) |
| <a name="output_id"></a> [id](#output\_id) | The ID of the droplet |
| <a name="output_image"></a> [image](#output\_image) | The image of the droplet |
| <a name="output_ipv4_address"></a> [ipv4\_address](#output\_ipv4\_address) | The IPv4 address of the droplet |
| <a name="output_ipv4_address_private"></a> [ipv4\_address\_private](#output\_ipv4\_address\_private) | The private IPv4 address of the droplet |
| <a name="output_ipv6_address"></a> [ipv6\_address](#output\_ipv6\_address) | The IPv6 address of the droplet |
| <a name="output_ipv6_address_private"></a> [ipv6\_address\_private](#output\_ipv6\_address\_private) | The private IPv6 address of the droplet |
| <a name="output_memory"></a> [memory](#output\_memory) | The amount of memory in MB |
| <a name="output_name"></a> [name](#output\_name) | The name of the droplet |
| <a name="output_price_hourly"></a> [price\_hourly](#output\_price\_hourly) | The hourly price of the droplet |
| <a name="output_price_monthly"></a> [price\_monthly](#output\_price\_monthly) | The monthly price of the droplet |
| <a name="output_region"></a> [region](#output\_region) | The region of the droplet |
| <a name="output_size"></a> [size](#output\_size) | The instance size of the droplet |
| <a name="output_status"></a> [status](#output\_status) | The status of the droplet |
| <a name="output_tags"></a> [tags](#output\_tags) | The tags applied to the droplet |
| <a name="output_urn"></a> [urn](#output\_urn) | The uniform resource name of the droplet |
| <a name="output_vcpus"></a> [vcpus](#output\_vcpus) | The number of virtual CPUs |
| <a name="output_vpc_uuid"></a> [vpc\_uuid](#output\_vpc\_uuid) | The ID of the VPC where the droplet is located |
<!-- END_TF_DOCS -->