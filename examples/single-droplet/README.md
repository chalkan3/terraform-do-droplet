# Example: Simple Single Droplet

This example demonstrates how to create a single DigitalOcean droplet using the droplet module.

## Usage

1. Copy the terraform.tfvars.example file:
```bash
cp terraform.tfvars.example terraform.tfvars
```

2. Edit terraform.tfvars with your values:
```bash
# Required
do_token = "your_digitalocean_token_here"

# Optional customization
droplet_name = "my-web-server"
droplet_size = "s-2vcpu-2gb"
droplet_region = "nyc3"
enable_backups = false
```

3. Initialize and apply:
```bash
terraform init
terraform plan
terraform apply
```

## What it creates

- 1 Ubuntu 22.04 droplet
- Firewall with SSH, HTTP, HTTPS access
- DigitalOcean monitoring enabled
- Proper tagging for organization

## Outputs

After successful deployment, you'll get:
- Droplet IP address
- Connection information
- Resource identifiers

## Clean up

```bash
terraform destroy
```

## Cost

Approximate cost for s-1vcpu-1gb: $6/month ($0.009/hour)