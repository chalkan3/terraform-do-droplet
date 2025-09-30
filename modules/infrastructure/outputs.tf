# VPC Outputs
output "vpc_id" {
  description = "The ID of the VPC"
  value       = var.create_vpc ? digitalocean_vpc.this[0].id : null
}

output "vpc_urn" {
  description = "The URN of the VPC"
  value       = var.create_vpc ? digitalocean_vpc.this[0].id : null
}

output "vpc_ip_range" {
  description = "The IP range of the VPC"
  value       = var.create_vpc ? digitalocean_vpc.this[0].ip_range : null
}

# SSH Key Outputs
output "ssh_key_id" {
  description = "The ID of the created SSH key"
  value       = var.ssh_public_key != null ? digitalocean_ssh_key.this[0].id : null
}

output "ssh_key_fingerprint" {
  description = "The fingerprint of the SSH key"
  value       = var.ssh_public_key != null ? digitalocean_ssh_key.this[0].fingerprint : null
}

# Project Outputs
output "project_id" {
  description = "The ID of the DigitalOcean project"
  value       = var.create_project ? digitalocean_project.this[0].id : null
}

output "project_urn" {
  description = "The URN of the DigitalOcean project"
  value       = var.create_project ? digitalocean_project.this[0].id : null
}

# Droplet Outputs
output "droplets" {
  description = "Map of droplet information"
  value = {
    for name, droplet in module.droplets : name => {
      id                    = droplet.id
      urn                   = droplet.urn
      name                  = droplet.name
      region                = droplet.region
      size                  = droplet.size
      image                 = droplet.image
      ipv4_address         = droplet.ipv4_address
      ipv4_address_private = droplet.ipv4_address_private
      ipv6_address         = droplet.ipv6_address
      vpc_uuid             = droplet.vpc_uuid
      status               = droplet.status
      tags                 = droplet.tags
      disk                 = droplet.disk
      vcpus                = droplet.vcpus
      memory               = droplet.memory
      price_hourly         = droplet.price_hourly
      price_monthly        = droplet.price_monthly
      firewall_id          = droplet.firewall_id
      firewall_name        = droplet.firewall_name
    }
  }
}

output "droplet_ids" {
  description = "List of droplet IDs"
  value       = [for droplet in module.droplets : droplet.id]
}

output "droplet_names" {
  description = "List of droplet names"
  value       = [for droplet in module.droplets : droplet.name]
}

output "droplet_ipv4_addresses" {
  description = "List of droplet IPv4 addresses"
  value       = [for droplet in module.droplets : droplet.ipv4_address]
}

output "droplet_ipv4_addresses_private" {
  description = "List of droplet private IPv4 addresses"
  value       = [for droplet in module.droplets : droplet.ipv4_address_private]
}

# Load Balancer Outputs
output "load_balancer_id" {
  description = "The ID of the load balancer"
  value       = var.create_load_balancer ? digitalocean_loadbalancer.this[0].id : null
}

output "load_balancer_ip" {
  description = "The IP address of the load balancer"
  value       = var.create_load_balancer ? digitalocean_loadbalancer.this[0].ip : null
}

output "load_balancer_urn" {
  description = "The URN of the load balancer"
  value       = var.create_load_balancer ? digitalocean_loadbalancer.this[0].id : null
}

output "load_balancer_status" {
  description = "The status of the load balancer"
  value       = var.create_load_balancer ? digitalocean_loadbalancer.this[0].status : null
}

# Connection Information
output "connection_info" {
  description = "Connection information for all droplets"
  value = {
    for name, droplet in module.droplets : name => {
      host        = droplet.ipv4_address
      user        = "root"
      private_key = null # Should be provided externally
    }
  }
  sensitive = true
}

# Summary Information
output "infrastructure_summary" {
  description = "Summary of the created infrastructure"
  value = {
    project            = var.project
    environment        = var.environment
    region             = var.region
    droplet_count     = length(module.droplets)
    vpc_created       = var.create_vpc
    project_created   = var.create_project
    load_balancer_created = var.create_load_balancer
    total_monthly_cost = sum([for droplet in module.droplets : droplet.price_monthly])
    total_hourly_cost  = sum([for droplet in module.droplets : droplet.price_hourly])
  }
}