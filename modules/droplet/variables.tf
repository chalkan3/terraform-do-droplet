# Basic Configuration
variable "name" {
  description = "Name of the droplet"
  type        = string
}

variable "image" {
  description = "Droplet image slug or ID"
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "region" {
  description = "DigitalOcean region"
  type        = string
  default     = "nyc3"
}

variable "size" {
  description = "Droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}

# Network Configuration
variable "vpc_uuid" {
  description = "VPC UUID to place the droplet in"
  type        = string
  default     = null
}

variable "ssh_keys" {
  description = "List of SSH key IDs or fingerprints"
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "User data script to run on droplet creation"
  type        = string
  default     = null
}

# Organization and Tagging
variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "default"
}

variable "tags" {
  description = "List of tags to apply to the droplet"
  type        = list(string)
  default     = []
}

# Features
variable "monitoring_enabled" {
  description = "Enable DigitalOcean monitoring"
  type        = bool
  default     = true
}

variable "backups_enabled" {
  description = "Enable DigitalOcean backups"
  type        = bool
  default     = false
}

variable "resize_disk" {
  description = "Allow disk resizing when changing droplet size"
  type        = bool
  default     = true
}

variable "graceful_shutdown" {
  description = "Enable graceful shutdown"
  type        = bool
  default     = true
}

# Storage
variable "volume_ids" {
  description = "List of volume IDs to attach to the droplet"
  type        = list(string)
  default     = []
}

# Firewall Configuration
variable "create_firewall" {
  description = "Whether to create a firewall for this droplet"
  type        = bool
  default     = false
}

variable "firewall_inbound_rules" {
  description = "List of inbound firewall rules"
  type = list(object({
    protocol         = string
    port_range       = string
    source_addresses = list(string)
  }))
  default = [
    {
      protocol         = "tcp"
      port_range       = "22"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "80"
      source_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol         = "tcp"
      port_range       = "443"
      source_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

variable "firewall_outbound_rules" {
  description = "List of outbound firewall rules"
  type = list(object({
    protocol              = string
    port_range           = string
    destination_addresses = list(string)
  }))
  default = [
    {
      protocol              = "tcp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    },
    {
      protocol              = "udp"
      port_range            = "1-65535"
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}