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

# Production Infrastructure with High Availability
module "prod_infrastructure" {
  source = "../../modules/infrastructure"

  project     = var.project_name
  environment = "prod"
  region      = var.region

  # Create VPC for security
  create_vpc    = true
  vpc_ip_range  = "10.20.0.0/20"

  # Create project for organization
  create_project = true
  project_purpose = "Web Application"

  # SSH key configuration
  ssh_public_key = var.ssh_public_key
  default_ssh_keys = var.additional_ssh_keys

  # Production settings
  default_tags = ["production", "terraform", "critical"]
  default_monitoring_enabled = true
  default_backups_enabled = true # Enable backups for production
  default_create_firewall = true

  # Load balancer configuration
  create_load_balancer = true
  load_balancer_entry_protocol = "https"
  load_balancer_entry_port = 443
  load_balancer_target_protocol = "http"
  load_balancer_target_port = 80
  load_balancer_certificate_name = var.ssl_certificate_name
  load_balancer_droplet_names = [
    "${var.project_name}-prod-web-1",
    "${var.project_name}-prod-web-2"
  ]

  # Health check configuration
  load_balancer_healthcheck_protocol = "http"
  load_balancer_healthcheck_path = "/health"
  load_balancer_healthcheck_interval = 10
  load_balancer_healthcheck_timeout = 5
  load_balancer_healthy_threshold = 2
  load_balancer_unhealthy_threshold = 3

  # Production droplets - multi-region setup
  droplets = [
    # Web servers (load balanced)
    {
      name = "${var.project_name}-prod-web-1"
      size = "s-2vcpu-4gb"
      region = var.region
      tags = ["web", "frontend", "loadbalanced"]
      monitoring_enabled = true
      backups_enabled = true
      
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
      
      user_data = var.web_server_user_data
    },
    {
      name = "${var.project_name}-prod-web-2"
      size = "s-2vcpu-4gb"
      region = var.backup_region
      tags = ["web", "frontend", "loadbalanced"]
      monitoring_enabled = true
      backups_enabled = true
      
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
      
      user_data = var.web_server_user_data
    },
    # API server
    {
      name = "${var.project_name}-prod-api"
      size = "s-4vcpu-8gb"
      region = var.region
      tags = ["api", "backend", "critical"]
      monitoring_enabled = true
      backups_enabled = true
      
      firewall_inbound_rules = [
        {
          protocol         = "tcp"
          port_range       = "22"
          source_addresses = var.allowed_ssh_ips
        },
        {
          protocol         = "tcp"
          port_range       = "8080"
          source_addresses = ["10.20.0.0/20"] # Only from VPC
        }
      ]
      
      user_data = var.api_server_user_data
    },
    # Database server
    {
      name = "${var.project_name}-prod-db"
      size = "s-2vcpu-4gb"
      region = var.region
      tags = ["database", "backend", "critical"]
      monitoring_enabled = true
      backups_enabled = true
      
      firewall_inbound_rules = [
        {
          protocol         = "tcp"
          port_range       = "22"
          source_addresses = var.allowed_ssh_ips
        },
        {
          protocol         = "tcp"
          port_range       = "5432"
          source_addresses = ["10.20.0.0/20"] # Only from VPC
        }
      ]
      
      user_data = var.database_user_data
    }
  ]
}