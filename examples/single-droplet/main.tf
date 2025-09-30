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

# Simple single droplet example
module "simple_droplet" {
  source = "../../modules/droplet"

  name        = var.droplet_name
  image       = var.droplet_image
  region      = var.droplet_region
  size        = var.droplet_size
  environment = var.environment
  project     = var.project_name

  # Enable firewall with default rules
  create_firewall = true

  # Enable monitoring
  monitoring_enabled = true
  backups_enabled    = var.enable_backups

  # Custom tags
  tags = var.droplet_tags
}