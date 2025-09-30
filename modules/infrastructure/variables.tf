# Project Configuration
variable "project" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "region" {
  description = "Default DigitalOcean region"
  type        = string
  default     = "nyc3"
}

# VPC Configuration
variable "create_vpc" {
  description = "Whether to create a VPC"
  type        = bool
  default     = false
}

variable "vpc_ip_range" {
  description = "IP range for the VPC"
  type        = string
  default     = "10.10.0.0/20"
}

# SSH Configuration
variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
  default     = null
}

variable "default_ssh_keys" {
  description = "Default SSH key IDs to use for all droplets"
  type        = list(string)
  default     = []
}

# Project Management
variable "create_project" {
  description = "Whether to create a DigitalOcean project"
  type        = bool
  default     = true
}

variable "project_purpose" {
  description = "Purpose of the project"
  type        = string
  default     = "Web Application"
}

# Default Settings for Droplets
variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = list(string)
  default     = []
}

variable "default_monitoring_enabled" {
  description = "Default monitoring setting for droplets"
  type        = bool
  default     = true
}

variable "default_backups_enabled" {
  description = "Default backup setting for droplets"
  type        = bool
  default     = false
}

variable "default_create_firewall" {
  description = "Default firewall creation setting"
  type        = bool
  default     = false
}

variable "default_firewall_inbound_rules" {
  description = "Default inbound firewall rules"
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

variable "default_firewall_outbound_rules" {
  description = "Default outbound firewall rules"
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
    },
    {
      protocol              = "icmp"
      port_range            = ""
      destination_addresses = ["0.0.0.0/0", "::/0"]
    }
  ]
}

# Droplets Configuration
variable "droplets" {
  description = "List of droplets to create"
  type = list(object({
    name     = string
    image    = optional(string, "ubuntu-22-04-x64")
    region   = optional(string)
    size     = optional(string, "s-1vcpu-1gb")
    vpc_uuid = optional(string)
    
    ssh_keys  = optional(list(string))
    user_data = optional(string)
    tags      = optional(list(string))
    
    monitoring_enabled = optional(bool)
    backups_enabled    = optional(bool)
    resize_disk        = optional(bool)
    graceful_shutdown  = optional(bool)
    
    create_firewall         = optional(bool)
    firewall_inbound_rules  = optional(list(object({
      protocol         = string
      port_range       = string
      source_addresses = list(string)
    })))
    firewall_outbound_rules = optional(list(object({
      protocol              = string
      port_range           = string
      destination_addresses = list(string)
    })))
    
    volume_ids = optional(list(string))
  }))
  default = []
}

# Load Balancer Configuration
variable "create_load_balancer" {
  description = "Whether to create a load balancer"
  type        = bool
  default     = false
}

variable "load_balancer_entry_protocol" {
  description = "Load balancer entry protocol"
  type        = string
  default     = "http"
}

variable "load_balancer_entry_port" {
  description = "Load balancer entry port"
  type        = number
  default     = 80
}

variable "load_balancer_target_protocol" {
  description = "Load balancer target protocol"
  type        = string
  default     = "http"
}

variable "load_balancer_target_port" {
  description = "Load balancer target port"
  type        = number
  default     = 80
}

variable "load_balancer_certificate_name" {
  description = "SSL certificate name for load balancer"
  type        = string
  default     = null
}

variable "load_balancer_tls_passthrough" {
  description = "Enable TLS passthrough"
  type        = bool
  default     = false
}

variable "load_balancer_healthcheck_protocol" {
  description = "Health check protocol"
  type        = string
  default     = "http"
}

variable "load_balancer_healthcheck_port" {
  description = "Health check port"
  type        = number
  default     = 80
}

variable "load_balancer_healthcheck_path" {
  description = "Health check path"
  type        = string
  default     = "/"
}

variable "load_balancer_healthcheck_interval" {
  description = "Health check interval in seconds"
  type        = number
  default     = 10
}

variable "load_balancer_healthcheck_timeout" {
  description = "Health check timeout in seconds"
  type        = number
  default     = 5
}

variable "load_balancer_healthy_threshold" {
  description = "Number of successful checks before marking healthy"
  type        = number
  default     = 2
}

variable "load_balancer_unhealthy_threshold" {
  description = "Number of failed checks before marking unhealthy"
  type        = number
  default     = 3
}

variable "load_balancer_sticky_sessions_type" {
  description = "Sticky sessions type"
  type        = string
  default     = null
}

variable "load_balancer_sticky_sessions_cookie_name" {
  description = "Sticky sessions cookie name"
  type        = string
  default     = null
}

variable "load_balancer_sticky_sessions_cookie_ttl" {
  description = "Sticky sessions cookie TTL"
  type        = number
  default     = null
}

variable "load_balancer_droplet_names" {
  description = "Names of droplets to include in load balancer"
  type        = list(string)
  default     = []
}

variable "load_balancer_vpc_uuid" {
  description = "VPC UUID for load balancer"
  type        = string
  default     = null
}

variable "load_balancer_firewall_rules" {
  description = "Firewall rules for load balancer"
  type = object({
    allow = optional(list(string))
    deny  = optional(list(string))
  })
  default = null
}