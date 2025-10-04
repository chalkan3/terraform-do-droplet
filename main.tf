terraform {
  required_version = ">= 1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

# Create a single droplet
resource "digitalocean_droplet" "this" {
  name       = var.droplet_name
  image      = var.droplet_image
  region     = var.droplet_region
  size       = var.droplet_size
  monitoring = true
  backups    = var.enable_backups
  tags       = var.droplet_tags
}

# Create firewall rules if specified
resource "digitalocean_firewall" "droplet_firewall" {
  count = var.create_firewall ? 1 : 0

  name = "${var.droplet_name}-firewall"

  droplet_ids = [digitalocean_droplet.this.id]

  # Default SSH access
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Default outbound rules
  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}