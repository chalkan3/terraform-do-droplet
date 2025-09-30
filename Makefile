# Terraform DigitalOcean Infrastructure Makefile
# Provides convenient commands for common Terraform operations

.PHONY: help init plan apply destroy validate fmt check clean

# Default target
help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

init: ## Initialize Terraform
	terraform init

plan: ## Create and show a Terraform execution plan
	terraform plan

apply: ## Apply Terraform configuration
	terraform apply

destroy: ## Destroy Terraform-managed infrastructure
	terraform destroy

validate: ## Validate Terraform configuration
	terraform validate

fmt: ## Format Terraform configuration files
	terraform fmt -recursive

check: validate fmt ## Run validation and formatting checks
	@echo "✅ Configuration is valid and formatted"

clean: ## Clean up Terraform files
	rm -rf .terraform
	rm -f .terraform.lock.hcl
	rm -f terraform.tfstate*

# Environment-specific targets
dev-init: ## Initialize development environment
	cd environments/dev && terraform init

dev-plan: ## Plan development environment
	cd environments/dev && terraform plan

dev-apply: ## Apply development environment
	cd environments/dev && terraform apply

dev-destroy: ## Destroy development environment
	cd environments/dev && terraform destroy

prod-init: ## Initialize production environment
	cd environments/prod && terraform init

prod-plan: ## Plan production environment
	cd environments/prod && terraform plan

prod-apply: ## Apply production environment
	cd environments/prod && terraform apply

prod-destroy: ## Destroy production environment
	cd environments/prod && terraform destroy

# Module validation
validate-modules: ## Validate all modules
	@echo "Validating droplet module..."
	cd modules/droplet && terraform init && terraform validate
	@echo "Validating infrastructure module..."
	cd modules/infrastructure && terraform init && terraform validate
	@echo "✅ All modules are valid"

# Example targets
example-single: ## Run single droplet example
	cd examples/single-droplet && terraform init && terraform plan

example-multi: ## Run multi droplet example
	cd examples/multi-droplet && terraform init && terraform plan

# Security checks
security-check: ## Run security checks (requires tfsec)
	@if command -v tfsec >/dev/null 2>&1; then \
		tfsec .; \
	else \
		echo "⚠️  tfsec not found. Install with: brew install tfsec"; \
	fi

# Documentation
docs: ## Generate module documentation (requires terraform-docs)
	@if command -v terraform-docs >/dev/null 2>&1; then \
		terraform-docs markdown table --output-file README.md modules/droplet/; \
		terraform-docs markdown table --output-file README.md modules/infrastructure/; \
		echo "✅ Documentation updated"; \
	else \
		echo "⚠️  terraform-docs not found. Install with: brew install terraform-docs"; \
	fi

# Quick setup for new users
setup: ## Quick setup for new users
	@echo "🚀 Setting up Terraform DigitalOcean project..."
	@echo "1. Copy example terraform.tfvars:"
	@if [ -f terraform.tfvars.example ]; then \
		cp terraform.tfvars.example terraform.tfvars; \
		echo "   ✅ Created terraform.tfvars from example"; \
	fi
	@echo "2. Edit terraform.tfvars with your DigitalOcean token"
	@echo "3. Run: make init plan apply"