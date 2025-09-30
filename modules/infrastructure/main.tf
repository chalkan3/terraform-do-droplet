terraform {
  required_version = ">= 1.0"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

# Create VPC if specified
resource "digitalocean_vpc" "this" {
  count = var.create_vpc ? 1 : 0

  name     = "${var.project}-${var.environment}-vpc"
  region   = var.region
  ip_range = var.vpc_ip_range

  description = "VPC for ${var.project} ${var.environment} environment"
}

# Create SSH Key if public key is provided
resource "digitalocean_ssh_key" "this" {
  count = var.ssh_public_key != null ? 1 : 0

  name       = "${var.project}-${var.environment}-key"
  public_key = var.ssh_public_key
}

# Create project for organization
resource "digitalocean_project" "this" {
  count = var.create_project ? 1 : 0

  name        = "${var.project}-${var.environment}"
  description = "${var.project} infrastructure for ${var.environment} environment"
  purpose     = var.project_purpose
  environment = var.environment == "dev" ? "development" : var.environment == "prod" ? "production" : var.environment

  resources = flatten([
    [for droplet in module.droplets : droplet.urn],
    var.create_vpc ? [digitalocean_vpc.this[0].id] : []
  ])
}

# Create droplets using the droplet module
module "droplets" {
  source   = "../droplet"
  for_each = { for idx, droplet in var.droplets : droplet.name => droplet }

  name     = each.value.name
  image    = each.value.image
  region   = each.value.region != null ? each.value.region : var.region
  size     = each.value.size
  vpc_uuid = var.create_vpc ? digitalocean_vpc.this[0].id : each.value.vpc_uuid

  ssh_keys  = concat(
    var.ssh_public_key != null ? [digitalocean_ssh_key.this[0].id] : [],
    each.value.ssh_keys != null ? each.value.ssh_keys : var.default_ssh_keys
  )
  user_data = each.value.user_data

  environment = var.environment
  project     = var.project
  tags        = concat(var.default_tags, each.value.tags != null ? each.value.tags : [])

  monitoring_enabled = each.value.monitoring_enabled != null ? each.value.monitoring_enabled : var.default_monitoring_enabled
  backups_enabled    = each.value.backups_enabled != null ? each.value.backups_enabled : var.default_backups_enabled
  resize_disk        = each.value.resize_disk != null ? each.value.resize_disk : true
  graceful_shutdown  = each.value.graceful_shutdown != null ? each.value.graceful_shutdown : true

  # Firewall configuration
  create_firewall        = each.value.create_firewall != null ? each.value.create_firewall : var.default_create_firewall
  firewall_inbound_rules = each.value.firewall_inbound_rules != null ? each.value.firewall_inbound_rules : var.default_firewall_inbound_rules
  firewall_outbound_rules = each.value.firewall_outbound_rules != null ? each.value.firewall_outbound_rules : var.default_firewall_outbound_rules

  volume_ids = each.value.volume_ids != null ? each.value.volume_ids : []
}

# Create load balancer if specified
resource "digitalocean_loadbalancer" "this" {
  count = var.create_load_balancer ? 1 : 0

  name   = "${var.project}-${var.environment}-lb"
  region = var.region

  forwarding_rule {
    entry_protocol  = var.load_balancer_entry_protocol
    entry_port      = var.load_balancer_entry_port
    target_protocol = var.load_balancer_target_protocol
    target_port     = var.load_balancer_target_port

    certificate_name = var.load_balancer_certificate_name
    tls_passthrough  = var.load_balancer_tls_passthrough
  }

  healthcheck {
    protocol                 = var.load_balancer_healthcheck_protocol
    port                     = var.load_balancer_healthcheck_port
    path                     = var.load_balancer_healthcheck_path
    check_interval_seconds   = var.load_balancer_healthcheck_interval
    response_timeout_seconds = var.load_balancer_healthcheck_timeout
    healthy_threshold        = var.load_balancer_healthy_threshold
    unhealthy_threshold      = var.load_balancer_unhealthy_threshold
  }

  sticky_sessions {
    type               = var.load_balancer_sticky_sessions_type
    cookie_name        = var.load_balancer_sticky_sessions_cookie_name
    cookie_ttl_seconds = var.load_balancer_sticky_sessions_cookie_ttl
  }

  droplet_ids = [for droplet in module.droplets : droplet.id if contains(var.load_balancer_droplet_names, split("/", droplet.name)[length(split("/", droplet.name)) - 1])]

  vpc_uuid = var.create_vpc ? digitalocean_vpc.this[0].id : var.load_balancer_vpc_uuid

  dynamic "firewall" {
    for_each = var.load_balancer_firewall_rules != null ? [1] : []
    content {
      allow  = var.load_balancer_firewall_rules.allow
      deny   = var.load_balancer_firewall_rules.deny
    }
  }
}