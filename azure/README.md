# Azure Paving

Terraform templates for paving Azure infrastructure.

## Requirements

- Terraform 1.0.11+
- Azure CLI (for authentication setup)
- Azure subscription with appropriate permissions

## Supported Versions

- **AzureRM Provider:** 3.117.1+
- **Terraform:** 1.0.11+

## Authentication

This module supports two authentication methods:

### Option 1: Client Secret (Password-based)

```hcl
# terraform.tfvars
subscription_id = "..."
tenant_id       = "..."
client_id       = "..."
client_secret   = "your-client-secret"
```

### Option 2: Client Certificate (Recommended for Production)

Certificate authentication is more secure and doesn't require managing secrets in configuration files.

**1. Export certificate to PKCS#12 format:**

```bash
# If you have a PEM certificate
openssl pkcs12 -export \
  -out cert.pfx \
  -in cert.pem \
  -passout pass:YOUR_PASSWORD
```

**2. Set environment variables:**

```bash
export ARM_CLIENT_CERTIFICATE_PATH="/path/to/cert.pfx"
export ARM_CLIENT_CERTIFICATE_PASSWORD="YOUR_PASSWORD"  # Optional, if certificate is encrypted
export ARM_CLIENT_ID="your-client-id"
export ARM_TENANT_ID="your-tenant-id"
export ARM_SUBSCRIPTION_ID="your-subscription-id"
```

**3. Run terraform (certificate auth via environment variables):**

```bash
terraform init
terraform plan
terraform apply
```

**Note:** When using certificate authentication, leave `client_secret` empty or omit it from `terraform.tfvars`.

## Usage

### 1. Create terraform.tfvars

```hcl
environment_name = "my-env"
subscription_id  = "..."
tenant_id        = "..."
client_id        = "..."
client_secret    = ""  # Leave empty if using certificate auth
location         = "East US"
hosted_zone      = "example.com"
```

### 2. Initialize and Apply

```bash
cd azure
terraform init
terraform plan -var-file terraform.tfvars
terraform apply -var-file terraform.tfvars
```

### 3. Get Outputs

```bash
terraform output stable_config_opsmanager
terraform output stable_config_pas
terraform output stable_config_pks
```