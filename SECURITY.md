# Security Guidelines for Terraform DigitalOcean Infrastructure

## 🔐 Credential Management

### ⚠️ NEVER commit the following:
- DigitalOcean API tokens
- SSH private keys
- SSL certificates and private keys
- Database passwords
- Any sensitive configuration values

### ✅ Secure credential storage:

#### 1. Environment Variables
```bash
# Add to your ~/.bashrc or ~/.zshrc
export TF_VAR_do_token="your_digitalocean_token"
export TF_VAR_ssh_public_key="$(cat ~/.ssh/id_rsa.pub)"
```

#### 2. Terraform Cloud/Enterprise
- Use workspace variables marked as "sensitive"
- Enable remote state encryption
- Configure team access controls

#### 3. Local Development
```bash
# Use terraform.tfvars (already in .gitignore)
echo 'do_token = "your_token_here"' > terraform.tfvars
```

## 🛡️ Infrastructure Security

### Network Security
```hcl
# Restrict SSH access
allowed_ssh_ips = [
  "office.ip.range/24",     # Office network
  "home.ip.address/32",     # Home IP
  "vpn.gateway.ip/32"       # VPN gateway
]

# Use VPC for isolation
create_vpc = true
vpc_ip_range = "10.0.0.0/16"
```

### Firewall Configuration
```hcl
# Minimal firewall rules
firewall_inbound_rules = [
  {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["trusted.ip.range/24"]
  },
  {
    protocol         = "tcp"
    port_range       = "80,443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }
]
```

### SSH Key Management
```hcl
# Use SSH keys, never passwords
ssh_public_key = var.ssh_public_key

# Rotate keys regularly
# Consider using multiple keys for different access levels
```

## 🔍 Security Monitoring

### Enable Monitoring
```hcl
# Always enable for production
monitoring_enabled = true
backups_enabled = true  # For production
```

### Audit Trail
- Enable DigitalOcean audit logs
- Use Terraform Cloud audit logs
- Monitor resource changes

## 🔒 Access Control

### Principle of Least Privilege
- Create separate DigitalOcean tokens for different environments
- Use read-only tokens where possible
- Regularly audit token usage

### Team Access
```hcl
# Use DigitalOcean teams for access control
# Implement role-based access
# Regular access reviews
```

## 🚨 Incident Response

### Security Checklist
- [ ] Tokens are not in version control
- [ ] SSH access is restricted to known IPs
- [ ] Firewalls are configured properly
- [ ] Monitoring is enabled
- [ ] Backups are configured for production
- [ ] SSL certificates are properly managed
- [ ] Regular security updates are applied

### Emergency Procedures
1. **Token Compromise**: Immediately revoke and rotate
2. **Unauthorized Access**: Check audit logs, change SSH keys
3. **Resource Deletion**: Restore from backups/state
4. **Network Breach**: Isolate affected resources

## 📋 Compliance

### Data Protection
- Encrypt data at rest
- Use HTTPS/SSL for data in transit
- Regular security assessments

### Regulatory Requirements
- Document security controls
- Maintain audit trails
- Regular compliance reviews

## 🔧 Tools and Automation

### Security Scanning
```bash
# Scan Terraform configurations
tfsec .

# Check for secrets in code
git-secrets --scan

# Validate configurations
terraform validate
terraform plan
```

### Automated Security
- Use pre-commit hooks for security checks
- Implement CI/CD security gates
- Regular vulnerability scanning

## 📚 Additional Resources

- [DigitalOcean Security Best Practices](https://docs.digitalocean.com/products/security/)
- [Terraform Security Best Practices](https://learn.hashicorp.com/tutorials/terraform/security)
- [CIS Security Benchmarks](https://www.cisecurity.org/cis-benchmarks/)

## 🆘 Security Support

If you discover a security vulnerability:
1. Do NOT create a public issue
2. Email security concerns privately
3. Provide detailed reproduction steps
4. Allow time for investigation and patching