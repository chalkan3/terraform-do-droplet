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
  description = "DigitalOcean region"
  type        = string
  default     = "nyc3"
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
  description = "List of IP addresses allowed to SSH"
  type        = list(string)
  default     = ["0.0.0.0/0", "::/0"]
}