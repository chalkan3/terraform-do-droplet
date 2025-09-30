# Contributing to Terraform DigitalOcean Infrastructure

We welcome contributions! Here's how you can help improve this project.

## 🚀 Quick Start for Contributors

1. **Fork the repository**
2. **Clone your fork**
   ```bash
   git clone https://github.com/YOUR_USERNAME/terraform-do-droplet.git
   cd terraform-do-droplet
   ```

3. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes**
5. **Test your changes**
   ```bash
   make validate-modules
   ```

6. **Commit and push**
   ```bash
   git add .
   git commit -m "feat: your feature description"
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**

## 🧪 Testing

### Validation
```bash
# Validate all modules
make validate-modules

# Format code
make fmt

# Security check (if tfsec installed)
make security-check
```

### Manual Testing
```bash
# Test single droplet example
cd examples/single-droplet
terraform init
terraform plan
```

## 📝 Code Guidelines

### Terraform Code Style
- Use consistent indentation (2 spaces)
- Add descriptions to all variables and outputs
- Use meaningful resource names
- Follow naming conventions:
  - Variables: `snake_case`
  - Resources: `snake_case` 
  - Modules: `kebab-case`

### Documentation
- Update README.md for significant changes
- Add inline comments for complex logic
- Update module documentation
- Include examples for new features

### Security
- Never commit sensitive data
- Use secure defaults
- Document security considerations
- Follow principle of least privilege

## 🎯 Types of Contributions

### 🐛 Bug Reports
- Use the issue template
- Include Terraform version
- Provide minimal reproduction case
- Include relevant logs

### ✨ Feature Requests
- Describe the use case
- Explain the proposed solution
- Consider backward compatibility
- Add examples if possible

### 📚 Documentation
- Fix typos and grammar
- Improve clarity
- Add missing examples
- Update outdated information

### 🔧 Code Contributions
- New modules or resources
- Bug fixes
- Performance improvements
- Security enhancements

## 📋 Checklist

Before submitting a PR, ensure:

- [ ] Code follows style guidelines
- [ ] All modules pass `terraform validate`
- [ ] Documentation is updated
- [ ] Examples are tested
- [ ] No sensitive data is committed
- [ ] Commit messages are descriptive
- [ ] PR description explains the changes

## 🏷️ Commit Message Convention

Use conventional commits:

- `feat:` New features
- `fix:` Bug fixes
- `docs:` Documentation changes
- `style:` Code style changes
- `refactor:` Code refactoring
- `test:` Test additions/changes
- `chore:` Maintenance tasks

Examples:
```
feat: add load balancer SSL configuration
fix: correct firewall rule port ranges
docs: update module usage examples
```

## 🤝 Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Follow the golden rule

## 📞 Getting Help

- **Documentation**: Check module README files
- **Issues**: Search existing issues first
- **Discussions**: Use GitHub Discussions for questions
- **Security**: Use private security reporting

## 🙏 Recognition

Contributors will be recognized in:
- README.md contributors section
- Release notes for significant contributions
- GitHub contributor graphs

Thank you for contributing! 🎉