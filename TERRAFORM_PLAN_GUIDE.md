# Como Fazer Terraform Plan

## 🎯 Diferentes Formas de Fazer Plan

### 1. **Exemplo Simples (Recomendado para Teste)**

```bash
# Entre no diretório do exemplo
cd terraform-do-droplet/examples/single-droplet

# Copie o arquivo de exemplo
cp terraform.tfvars.example terraform.tfvars

# Edite com seu token (NÃO commite este arquivo!)
nano terraform.tfvars  # ou vim, code, etc.

# Execute o plan
terraform plan
```

### 2. **Usando Variáveis de Ambiente (Mais Seguro)**

```bash
# Configure o token como variável de ambiente
export TF_VAR_do_token="seu_token_aqui"

# Execute o plan sem arquivo tfvars
terraform plan
```

### 3. **Plan com Arquivo Específico**

```bash
# Plan usando arquivo específico
terraform plan -var-file="production.tfvars"

# Plan com múltiplas variáveis
terraform plan \
  -var="do_token=seu_token" \
  -var="droplet_name=meu-droplet"
```

### 4. **Plan com Output para Arquivo**

```bash
# Salvar plan para revisar depois
terraform plan -out=tfplan

# Aplicar exatamente o que foi planejado
terraform apply tfplan
```

### 5. **Plan para Ambientes Específicos**

```bash
# Ambiente de desenvolvimento
cd environments/dev
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars
terraform plan

# Ambiente de produção
cd environments/prod
cp terraform.tfvars.example terraform.tfvars
# Editar terraform.tfvars
terraform plan
```

## 📋 Estrutura do terraform.tfvars

### Exemplo Básico:
```hcl
# DigitalOcean Token (obrigatório)
do_token = "dop_v1_xxx..."

# Configuração do Droplet
droplet_name = "meu-servidor"
droplet_region = "nyc3"
droplet_size = "s-1vcpu-1gb"

# Organização
environment = "dev"
project_name = "meu-projeto"

# Recursos opcionais
enable_backups = false
droplet_tags = ["web", "terraform"]
```

### Exemplo Avançado (Produção):
```hcl
do_token = "dop_v1_xxx..."
project_name = "webapp-prod"

# SSL Certificate
ssl_certificate_name = "meu-certificado-ssl"

# SSH Keys
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2E..."
allowed_ssh_ips = ["203.0.113.0/24"]  # IPs do escritório

# User data scripts
web_server_user_data = file("scripts/setup-web.sh")
```

## 🛠️ Comandos Úteis do Makefile

```bash
# Plan usando o Makefile
make plan

# Plan para ambiente específico
make dev-plan
make prod-plan

# Validar antes do plan
make validate

# Plan com formatação
make fmt && make plan
```

## ⚠️ Importante - Segurança

### ❌ NÃO faça:
```bash
# NUNCA commite arquivos com tokens
git add terraform.tfvars  # ❌ PERIGOSO!

# NUNCA exponha tokens em comandos
terraform plan -var="do_token=dop_v1_xxx"  # ❌ Fica no histórico!
```

### ✅ Faça:
```bash
# Use variáveis de ambiente
export TF_VAR_do_token="xxx"

# Ou use arquivos locais (já no .gitignore)
echo 'do_token = "xxx"' > terraform.tfvars

# Verificar se não há dados sensíveis
grep -r "dop_v1" . --exclude-dir=.git
```

## 🎯 Exemplo Prático Completo

```bash
# 1. Clone o repositório
git clone https://github.com/chalkan3/terraform-do-droplet.git
cd terraform-do-droplet

# 2. Vá para o exemplo simples
cd examples/single-droplet

# 3. Configure as credenciais
cp terraform.tfvars.example terraform.tfvars
nano terraform.tfvars  # Adicione seu token

# 4. Execute o plan
terraform init  # Se ainda não fez
terraform plan

# 5. Se tudo estiver ok, aplique
terraform apply

# 6. Limpe quando terminar
terraform destroy
rm terraform.tfvars  # Remove arquivo com token
```

## 🔍 Interpretando o Output do Plan

### Símbolos:
- `+` = Recursos que serão **criados**
- `-` = Recursos que serão **destruídos**  
- `~` = Recursos que serão **modificados**
- `<=` = Recursos que serão **recriados**

### Informações Mostradas:
- **Recursos**: Tipos e nomes dos recursos
- **Atributos**: Configurações que serão aplicadas
- **Outputs**: Valores que serão exportados
- **Resumo**: Quantos recursos serão alterados

## 💰 Estimativa de Custos

O plan mostra o tipo de droplet que será criado. Para estimar custos:

- `s-1vcpu-1gb`: $6/mês ($0.009/hora)
- `s-1vcpu-2gb`: $12/mês ($0.018/hora)  
- `s-2vcpu-2gb`: $18/mês ($0.027/hora)
- `s-2vcpu-4gb`: $24/mês ($0.036/hora)

**Dica**: Use `droplet_size = "s-1vcpu-1gb"` para testes!