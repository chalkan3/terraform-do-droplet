variable "do_token" {
  description = "DigitalOcean API token"
  type        = string
  sensitive   = true
}

variable "droplet_name" {
  description = "Name of the droplet"
  type        = string
  default     = "example-droplet"
}

variable "droplet_image" {
  description = "Droplet image"
  type        = string
  default     = "ubuntu-22-04-x64"
}

variable "droplet_region" {
  description = "Droplet region"
  type        = string
  default     = "nyc3"
}

variable "droplet_size" {
  description = "Droplet size"
  type        = string
  default     = "s-1vcpu-1gb"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "example"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "single-droplet-example"
}

variable "enable_backups" {
  description = "Enable backups"
  type        = bool
  default     = false
}

variable "droplet_tags" {
  description = "Tags for the droplet"
  type        = list(string)
  default     = ["example", "terraform"]
}