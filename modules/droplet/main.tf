terraform {
  required_version = ">= 1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

resource "digitalocean_droplet" "this" {
  name       = var.name
  image      = var.image
  region     = var.region
  size       = var.size
  vpc_uuid   = var.vpc_uuid
  ssh_keys   = var.ssh_keys
  user_data  = var.user_data
  
  tags = concat(
    var.tags,
    [
      "terraform-managed",
      var.environment,
      var.project
    ]
  )

  # Enable monitoring and backups based on variables
  monitoring = var.monitoring_enabled
  backups    = var.backups_enabled

  # Resize disk if needed
  resize_disk = var.resize_disk

  # Graceful shutdown
  graceful_shutdown = var.graceful_shutdown

  # Volume attachments
  volume_ids = var.volume_ids
}

# Create firewall rules if specified
resource "digitalocean_firewall" "droplet_firewall" {
  count = var.create_firewall ? 1 : 0
  
  name = "${var.name}-firewall"
  
  droplet_ids = [digitalocean_droplet.this.id]
  
  dynamic "inbound_rule" {
    for_each = var.firewall_inbound_rules
    content {
      protocol         = inbound_rule.value.protocol
      port_range       = inbound_rule.value.port_range
      source_addresses = inbound_rule.value.source_addresses
    }
  }
  
  dynamic "outbound_rule" {
    for_each = var.firewall_outbound_rules
    content {
      protocol              = outbound_rule.value.protocol
      port_range           = outbound_rule.value.port_range
      destination_addresses = outbound_rule.value.destination_addresses
    }
  }

  tags = var.tags
}