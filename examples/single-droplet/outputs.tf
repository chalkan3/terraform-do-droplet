output "droplet_id" {
  description = "The ID of the created droplet"
  value       = module.simple_droplet.id
}

output "droplet_name" {
  description = "The name of the droplet"
  value       = module.simple_droplet.name
}

output "droplet_ipv4_address" {
  description = "The public IPv4 address of the droplet"
  value       = module.simple_droplet.ipv4_address
}

output "droplet_ipv4_address_private" {
  description = "The private IPv4 address of the droplet"
  value       = module.simple_droplet.ipv4_address_private
}

output "droplet_region" {
  description = "The region where the droplet is located"
  value       = module.simple_droplet.region
}

output "droplet_size" {
  description = "The size of the droplet"
  value       = module.simple_droplet.size
}

output "droplet_status" {
  description = "The status of the droplet"
  value       = module.simple_droplet.status
}

output "firewall_id" {
  description = "The ID of the firewall (if created)"
  value       = module.simple_droplet.firewall_id
}

output "cost_monthly" {
  description = "Monthly cost in USD"
  value       = module.simple_droplet.price_monthly
}

output "cost_hourly" {
  description = "Hourly cost in USD"
  value       = module.simple_droplet.price_hourly
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh root@${module.simple_droplet.ipv4_address}"
}