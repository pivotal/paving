#!/bin/bash
set -e

echo "===== Testing AzureRM v3.x with Certificate Authentication ====="

# Extract certificate from terraform.tfvars
echo "Extracting certificate..."
sed -n '/^client_certificate = <<CLIENT_CERTIFICATE$/,/^CLIENT_CERTIFICATE$/p' terraform.tfvars | \
  sed '1d;$d' > /tmp/cert.pem

# Convert to PFX
echo "Converting certificate to PFX..."
openssl pkcs12 -export \
  -out /tmp/cert.pfx \
  -in /tmp/cert.pem \
  -passout pass:

# Set environment variables for Azure authentication
export ARM_CLIENT_CERTIFICATE_PATH="/tmp/cert.pfx"
export ARM_CLIENT_ID="$(grep '^client_id' terraform.tfvars | cut -d'=' -f2 | tr -d ' "')"
export ARM_TENANT_ID="$(grep '^tenant_id' terraform.tfvars | cut -d'=' -f2 | tr -d ' "')"
export ARM_SUBSCRIPTION_ID="$(grep '^subscription_id' terraform.tfvars | cut -d'=' -f2 | tr -d ' "')"

echo "Azure authentication configured:"
echo "  ARM_CLIENT_ID: $ARM_CLIENT_ID"
echo "  ARM_TENANT_ID: $ARM_TENANT_ID"
echo "  ARM_SUBSCRIPTION_ID: $ARM_SUBSCRIPTION_ID"
echo "  ARM_CLIENT_CERTIFICATE_PATH: $ARM_CLIENT_CERTIFICATE_PATH"
echo ""

# Remove PAS and PKS templates (we only need ops-manager)
echo "Removing PAS and PKS templates..."
rm -f pas-*.tf pks-*.tf || true

# Clean previous terraform state
echo "Cleaning previous terraform state..."
rm -rf .terraform .terraform.lock.hcl || true

# Test terraform init
echo ""
echo "===== Running terraform init ====="
terraform init

# Test terraform validate
echo ""
echo "===== Running terraform validate ====="
terraform validate

# Test terraform plan (will show if there are any syntax errors)
echo ""
echo "===== Running terraform plan ====="
terraform plan -var 'client_secret=""' || {
  echo ""
  echo "===== Terraform plan failed, but let's check the error ====="
  exit 1
}

echo ""
echo "===== SUCCESS! AzureRM v3.x works with certificate authentication ====="
echo ""
echo "Key findings:"
echo "  ✓ terraform init - succeeded"
echo "  ✓ terraform validate - succeeded"
echo "  ✓ terraform plan - check output above"
echo ""
echo "Did you see the '403 Error listing Service Principals' error?"
echo "  - If NO: v3.x solves the permission issue!"
echo "  - If YES: v3.x still has the same problem"
