# ❌ Erro: "Module not installed" - Como Resolver

## 🎯 **Problema:**
```
│ Error: Module not installed
│ on main.tf line 17:
│ 17: module "dev_infrastructure" {
│ This module is not yet installed. Run "terraform init" to install all modules required by this configuration.
```

## ✅ **Solução: Execute `terraform init`**

### **1. Identifique onde você está:**
```bash
pwd  # Mostra diretório atual
```

### **2. Execute terraform init no diretório correto:**

#### **Se estiver em `environments/dev/`:**
```bash
cd /caminho/para/terraform-do-droplet/environments/dev
terraform init
```

#### **Se estiver em `environments/prod/`:**
```bash
cd /caminho/para/terraform-do-droplet/environments/prod  
terraform init
```

#### **Se estiver em `examples/single-droplet/`:**
```bash
cd /caminho/para/terraform-do-droplet/examples/single-droplet
terraform init  # Já foi feito anteriormente
```

---

# ❌ Erro: "Unsupported attribute urn" - Como Resolver

## 🎯 **Problema:**
```
│ Error: Unsupported attribute
│ on ../../modules/infrastructure/outputs.tf line 36:
│ 36: value = digitalocean_project.this[0].urn
│ This object has no argument, nested block, or exported attribute named "urn".
```

## ✅ **Solução: Use 'id' ao invés de 'urn'**

### **Recursos que NÃO têm atributo 'urn':**
- `digitalocean_project` → Use `.id`
- `digitalocean_vpc` → Use `.id`  
- `digitalocean_loadbalancer` → Use `.id`

### **Recursos que TÊM atributo 'urn':**
- `digitalocean_droplet` → Pode usar `.urn`

### **Correções já aplicadas:**
```hcl
# ❌ Antes (erro)
digitalocean_project.this[0].urn

# ✅ Depois (correto)
digitalocean_project.this[0].id
```

### **3. Comando universal (use este se não souber onde está):**
```bash
# Vá para a raiz do projeto
cd terraform-do-droplet

# Inicialize todos os ambientes
cd environments/dev && terraform init && cd ..
cd environments/prod && terraform init && cd ..  
cd examples/single-droplet && terraform init && cd ../..
```

## 🔧 **O que o `terraform init` faz:**

### **1. Baixa Providers:**
```bash
# Instala o provider do DigitalOcean
- Installing digitalocean/digitalocean v2.67.0...
```

### **2. Inicializa Módulos:**
```bash
# Configura os módulos locais
- dev_infrastructure in ../../modules/infrastructure
- dev_infrastructure.droplets in ../../modules/droplet
```

### **3. Cria Arquivos:**
```bash
.terraform/           # Diretório com providers e módulos
.terraform.lock.hcl   # Lock file das versões
```

## 📁 **Estrutura Após terraform init:**

```
environments/dev/
├── .terraform/                 # ← Criado pelo init
│   ├── modules/               # Módulos baixados
│   └── providers/             # Providers baixados
├── .terraform.lock.hcl        # ← Criado pelo init
├── main.tf
├── variables.tf
└── outputs.tf
```

## 🚀 **Comandos Passo a Passo:**

### **Método 1: Ambiente Dev**
```bash
cd terraform-do-droplet/environments/dev
terraform init
terraform validate  # Verificar se está ok
terraform plan      # Fazer o plan
```

### **Método 2: Ambiente Prod**
```bash
cd terraform-do-droplet/environments/prod
terraform init
terraform validate
terraform plan
```

### **Método 3: Exemplo Simples**
```bash
cd terraform-do-droplet/examples/single-droplet
terraform init      # Se não foi feito ainda
terraform validate
terraform plan
```

## 🛠️ **Usando o Makefile (Mais Fácil):**

```bash
# Da raiz do projeto
make dev-init      # Inicializa ambiente dev
make prod-init     # Inicializa ambiente prod

# Ou comandos combinados
make dev-init dev-plan     # Init + Plan para dev
make prod-init prod-plan   # Init + Plan para prod
```

## ⚠️ **Problemas Comuns:**

### **1. Erro de Path de Módulo:**
```bash
# ❌ Se você estiver no diretório errado
Error: Module not found

# ✅ Certifique-se de estar no diretório certo
cd environments/dev/  # Não na raiz do projeto
```

### **2. Erro de Permissions:**
```bash
# ❌ Se der erro de permissão
Permission denied

# ✅ Verifique permissões
ls -la .terraform/
chmod -R 755 .terraform/
```

### **3. Cache Corrompido:**
```bash
# ❌ Se der erro estranho nos módulos
Error downloading modules

# ✅ Limpe e reinicialize
rm -rf .terraform/
terraform init
```

## 🎯 **Verificação Final:**

Após `terraform init`, você deve ver:
```bash
✅ Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure.
```

## 📋 **Checklist de Resolução:**

- [ ] Identifiquei o diretório correto (dev/prod/examples)
- [ ] Executei `terraform init` no diretório
- [ ] Vi a mensagem "successfully initialized"
- [ ] Arquivo `.terraform.lock.hcl` foi criado
- [ ] Diretório `.terraform/` foi criado
- [ ] `terraform validate` passa sem erros
- [ ] Posso executar `terraform plan` agora

## 🚀 **Próximos Passos:**

```bash
# Após terraform init bem-sucedido:
terraform validate   # Validar configuração
terraform plan      # Ver o que será criado
terraform apply     # Aplicar (se quiser criar recursos)
```

**Resumo**: O erro "Module not installed" sempre se resolve com `terraform init` no diretório correto! 🎉