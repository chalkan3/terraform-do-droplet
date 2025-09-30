# Terraform DigitalOcean Droplet Infrastructure

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?style=flat&logo=terraform)](https://www.terraform.io/)
[![DigitalOcean](https://img.shields.io/badge/DigitalOcean-Compatible-0080FF?style=flat&logo=digitalocean)](https://www.digitalocean.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

🚀 **Professional Terraform modules for managing DigitalOcean droplets with best practices and enterprise-grade structure.**

This repository provides reusable Terraform modules for creating and managing DigitalOcean infrastructure with a focus on modularity, security, and maintainability.

## 🏗️ Architecture

```
terraform-do-droplet/
├── modules/
│   ├── droplet/           # Individual droplet module
│   ├── infrastructure/    # Complete infrastructure module
│   └── network/           # Network components (VPC, firewall)
├── environments/
│   ├── dev/              # Development environment
│   ├── staging/          # Staging environment
│   └── prod/             # Production environment
└── examples/
    ├── single-droplet/   # Simple single droplet
    ├── multi-droplet/    # Multiple droplets
    └── load-balanced/    # Load balanced setup
```

## ✨ Features

### 🧱 Modular Design
- **Droplet Module**: Single droplet with all configuration options
- **Infrastructure Module**: Complete infrastructure with VPC, load balancer, and multiple droplets
- **Network Module**: Standalone networking components

### 🔒 Security First
- Configurable firewall rules
- VPC isolation
- SSH key management
- Restricted access patterns

### 📊 Production Ready
- Monitoring enabled by default
- Backup configuration
- Load balancer support
- Multi-region deployment

### 🏷️ Organization
- Automatic tagging
- Project management
- Environment separation
- Resource naming conventions

## 🚀 Quick Start

### 1. Single Droplet

```hcl
module "web_server" {
  source = "./modules/droplet"

  name        = "web-server-01"
  region      = "nyc3"
  size        = "s-2vcpu-2gb"
  environment = "production"
  
  create_firewall = true
  monitoring_enabled = true
  
  tags = ["web", "frontend"]
}
```

### 2. Complete Infrastructure

```hcl
module "webapp_infrastructure" {
  source = "./modules/infrastructure"

  project     = "webapp"
  environment = "production"
  region      = "nyc3"

  create_vpc = true
  create_load_balancer = true

  droplets = [
    {
      name = "web-1"
      size = "s-2vcpu-4gb"
      tags = ["web", "frontend"]
    },
    {
      name = "api-1"
      size = "s-4vcpu-8gb"
      tags = ["api", "backend"]
    }
  ]
}
```

## 📁 Module Documentation

### [Droplet Module](./modules/droplet/README.md)
Single droplet creation with full configuration options.

### [Infrastructure Module](./modules/infrastructure/README.md)
Complete infrastructure setup with VPC, load balancer, and multiple droplets.

## 🌍 Environment Examples

### Development
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

### Production
```bash
cd environments/prod
terraform init
terraform plan
terraform apply
```

## ⚙️ Configuration

### Required Variables
```hcl
# DigitalOcean API Token
do_token = "your_digitalocean_token"
```

### Optional Configuration
```hcl
# Project settings
project_name = "my-project"
region      = "nyc3"

# SSH access
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2E..."
allowed_ssh_ips = ["your.ip.address/32"]

# SSL certificate (for load balancer)
ssl_certificate_name = "my-cert"
```

## 🔧 Advanced Features

### Custom Firewall Rules
```hcl
firewall_inbound_rules = [
  {
    protocol         = "tcp"
    port_range       = "80,443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  },
  {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["office.ip.range/24"]
  }
]
```

### Load Balancer Configuration
```hcl
create_load_balancer = true
load_balancer_entry_protocol = "https"
load_balancer_certificate_name = "my-ssl-cert"
load_balancer_droplet_names = ["web-1", "web-2"]
```

### User Data Scripts
```hcl
user_data = file("${path.module}/scripts/setup-web-server.sh")
```

## 💰 Cost Optimization

- Use appropriate droplet sizes for each environment
- Disable backups for development environments
- Implement auto-scaling for production workloads
- Monitor resource utilization

## 🔐 Security Best Practices

1. **Network Security**
   - Use VPCs for isolation
   - Restrict SSH access to specific IPs
   - Configure appropriate firewall rules

2. **Access Control**
   - Use SSH keys instead of passwords
   - Rotate access tokens regularly
   - Implement least privilege access

3. **Monitoring**
   - Enable DigitalOcean monitoring
   - Set up alerts for critical metrics
   - Regular security audits

## 📊 Monitoring and Maintenance

### Terraform State Management
- Use remote state storage (S3, DigitalOcean Spaces)
- Enable state locking
- Regular state backups

### Resource Monitoring
- Monitor droplet performance
- Track costs and usage
- Regular security updates

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: Check module README files
- **Issues**: Open a GitHub issue
- **Community**: Join the discussion

## 🔗 Useful Links

- [DigitalOcean Terraform Provider](https://registry.terraform.io/providers/digitalocean/digitalocean/latest)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [DigitalOcean Documentation](https://docs.digitalocean.com/)

---

**Built with ❤️ for the Terraform community**