# Infrastructure Outputs
output "infrastructure_summary" {
  description = "Summary of the development infrastructure"
  value       = module.dev_infrastructure.infrastructure_summary
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.dev_infrastructure.vpc_id
}

output "droplets" {
  description = "Droplet information"
  value       = module.dev_infrastructure.droplets
}

output "droplet_ips" {
  description = "Public IP addresses of droplets"
  value = {
    for name, droplet in module.dev_infrastructure.droplets : name => droplet.ipv4_address
  }
}

output "ssh_connection_commands" {
  description = "SSH connection commands for each droplet"
  value = {
    for name, droplet in module.dev_infrastructure.droplets : name => "ssh root@${droplet.ipv4_address}"
  }
}