output "droplet_id" {
  description = "The ID of the created droplet"
  value       = digitalocean_droplet.this.id
}

output "droplet_name" {
  description = "The name of the droplet"
  value       = digitalocean_droplet.this.name
}

output "droplet_ipv4_address" {
  description = "The public IPv4 address of the droplet"
  value       = digitalocean_droplet.this.ipv4_address
}

output "droplet_region" {
  description = "The region where the droplet is located"
  value       = digitalocean_droplet.this.region
}

output "droplet_size" {
  description = "The size of the droplet"
  value       = digitalocean_droplet.this.size
}

output "droplet_status" {
  description = "The status of the droplet"
  value       = digitalocean_droplet.this.status
}

output "firewall_id" {
  description = "The ID of the firewall (if created)"
  value       = join("", digitalocean_firewall.droplet_firewall.*.id)
}

output "cost_monthly" {
  description = "Monthly cost in USD"
  value       = digitalocean_droplet.this.price_monthly
}

output "cost_hourly" {
  description = "Hourly cost in USD"
  value       = digitalocean_droplet.this.price_hourly
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh root@${digitalocean_droplet.this.ipv4_address}"
}