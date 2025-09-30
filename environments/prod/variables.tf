# Provider Configuration
variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

# Project Configuration
variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "webapp"
}

variable "region" {
  description = "Primary DigitalOcean region"
  type        = string
  default     = "nyc3"
}

variable "backup_region" {
  description = "Backup DigitalOcean region for redundancy"
  type        = string
  default     = "sfo3"
}

# SSL Configuration
variable "ssl_certificate_name" {
  description = "Name of the SSL certificate in DigitalOcean"
  type        = string
  default     = null
}

# SSH Configuration
variable "ssh_public_key" {
  description = "SSH public key content"
  type        = string
  default     = null
}

variable "additional_ssh_keys" {
  description = "Additional SSH key IDs"
  type        = list(string)
  default     = []
}

variable "allowed_ssh_ips" {
  description = "List of IP addresses allowed to SSH (should be restricted in prod)"
  type        = list(string)
  default     = ["0.0.0.0/0", "::/0"]
}

# User Data Scripts
variable "web_server_user_data" {
  description = "User data script for web servers"
  type        = string
  default     = null
}

variable "api_server_user_data" {
  description = "User data script for API server"
  type        = string
  default     = null
}

variable "database_user_data" {
  description = "User data script for database server"
  type        = string
  default     = null
}