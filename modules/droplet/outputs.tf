output "id" {
  description = "The ID of the droplet"
  value       = digitalocean_droplet.this.id
}

output "urn" {
  description = "The uniform resource name of the droplet"
  value       = digitalocean_droplet.this.urn
}

output "name" {
  description = "The name of the droplet"
  value       = digitalocean_droplet.this.name
}

output "region" {
  description = "The region of the droplet"
  value       = digitalocean_droplet.this.region
}

output "size" {
  description = "The instance size of the droplet"
  value       = digitalocean_droplet.this.size
}

output "image" {
  description = "The image of the droplet"
  value       = digitalocean_droplet.this.image
}

output "ipv4_address" {
  description = "The IPv4 address of the droplet"
  value       = digitalocean_droplet.this.ipv4_address
}

output "ipv4_address_private" {
  description = "The private IPv4 address of the droplet"
  value       = digitalocean_droplet.this.ipv4_address_private
}

output "ipv6_address" {
  description = "The IPv6 address of the droplet"
  value       = digitalocean_droplet.this.ipv6_address
}

output "vpc_uuid" {
  description = "The ID of the VPC where the droplet is located"
  value       = digitalocean_droplet.this.vpc_uuid
}

output "status" {
  description = "The status of the droplet"
  value       = digitalocean_droplet.this.status
}

output "tags" {
  description = "The tags applied to the droplet"
  value       = digitalocean_droplet.this.tags
}

output "disk" {
  description = "The size of the instance's disk in GB"
  value       = digitalocean_droplet.this.disk
}

output "vcpus" {
  description = "The number of virtual CPUs"
  value       = digitalocean_droplet.this.vcpus
}

output "memory" {
  description = "The amount of memory in MB"
  value       = digitalocean_droplet.this.memory
}

output "price_hourly" {
  description = "The hourly price of the droplet"
  value       = digitalocean_droplet.this.price_hourly
}

output "price_monthly" {
  description = "The monthly price of the droplet"
  value       = digitalocean_droplet.this.price_monthly
}

# Firewall outputs
output "firewall_id" {
  description = "The ID of the firewall (if created)"
  value       = var.create_firewall ? digitalocean_firewall.droplet_firewall[0].id : null
}

output "firewall_name" {
  description = "The name of the firewall (if created)"
  value       = var.create_firewall ? digitalocean_firewall.droplet_firewall[0].name : null
}

# Connection information for provisioners
output "connection_info" {
  description = "Connection information for SSH"
  value = {
    host        = digitalocean_droplet.this.ipv4_address
    user        = "root"
    private_key = null # Should be provided externally
  }
  sensitive = true
}