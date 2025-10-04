# Terraform DigitalOcean Droplet

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?style=flat&logo=terraform)](https://www.terraform.io/)
[![DigitalOcean](https://img.shields.io/badge/DigitalOcean-Compatible-0080FF?style=flat&logo=digitalocean)](https://www.digitalocean.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![GitHub](https://img.shields.io/github/license/chalkan3/terraform-do-droplet)](https://github.com/chalkan3/terraform-do-droplet/blob/master/LICENSE)
[![Validation](https://img.shields.io/badge/Terraform-Validated-success?style=flat&logo=terraform)](https://www.terraform.io/)

🏗️ **A simplified Terraform setup for creating a single DigitalOcean Droplet.**

This repository provides a straightforward Terraform configuration for creating a single DigitalOcean Droplet with basic security and monitoring.

## 🚀 Quick Start

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/chalkan3/terraform-do-droplet.git
    cd terraform-do-droplet
    ```

2.  **Configure your variables:**

    Copy the `terraform.tfvars.example` file to `terraform.tfvars` and add your DigitalOcean API token.
    ```bash
    cp terraform.tfvars.example terraform.tfvars
    ```
    Edit `terraform.tfvars` and set your `do_token`. You can also customize other variables like `droplet_name`, `droplet_region`, etc.

3.  **Initialize and apply Terraform:**
    ```bash
    terraform init
    terraform apply
    ```

    Terraform will provision the Droplet and output its IP address.

## ⚙️ Configuration

### Required Variables
```hcl
# DigitalOcean API Token
do_token = "your_digitalocean_token"
```

### Optional Configuration
You can customize the Droplet by editing `terraform.tfvars`:
```hcl
# Droplet Configuration
droplet_name   = "example-droplet"
droplet_image  = "ubuntu-22-04-x64"
droplet_region = "nyc3"
droplet_size   = "s-1vcpu-1gb"

# Features
enable_backups = false

# Tags
droplet_tags = ["example", "terraform", "web"]
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.