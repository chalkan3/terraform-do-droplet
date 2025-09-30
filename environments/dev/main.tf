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

# Development Infrastructure
module "dev_infrastructure" {
  source = "../../modules/infrastructure"

  project     = var.project_name
  environment = "dev"
  region      = var.region

  # Create VPC for isolation
  create_vpc    = true
  vpc_ip_range  = "10.10.0.0/20"

  # Create project for organization
  create_project = true
  project_purpose = "Web Application"

  # SSH key configuration
  ssh_public_key = var.ssh_public_key
  default_ssh_keys = var.additional_ssh_keys

  # Default settings for dev environment
  default_tags = ["development", "terraform"]
  default_monitoring_enabled = true
  default_backups_enabled = false # Disable backups for dev to save cost
  default_create_firewall = true

  # Development droplets configuration
  droplets = [
    {
      name = "${var.project_name}-dev-web"
      size = "s-1vcpu-1gb"
      tags = ["web", "frontend"]
      
      # Custom firewall for web server
      firewall_inbound_rules = [
        {
          protocol         = "tcp"
          port_range       = "22"
          source_addresses = var.allowed_ssh_ips
        },
        {
          protocol         = "tcp"
          port_range       = "80,443"
          source_addresses = ["0.0.0.0/0", "::/0"]
        }
      ]
    },
    {
      name = "${var.project_name}-dev-api"
      size = "s-1vcpu-2gb"
      tags = ["api", "backend"]
      
      # API server firewall
      firewall_inbound_rules = [
        {
          protocol         = "tcp"
          port_range       = "22"
          source_addresses = var.allowed_ssh_ips
        },
        {
          protocol         = "tcp"
          port_range       = "8080"
          source_addresses = ["10.10.0.0/20"] # Only from VPC
        }
      ]
    }
  ]
}