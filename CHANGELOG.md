# Changelog

## 3.0.0

### Breaking changes

- `GCP`: Added a new variable `location` on the variables which sets the location of the bucket `ops-manager`.

- Updated the templates to use `terraform` version `1.0.11`.
- Terraform providers updated and templates adjusted to remove deprecation warnings and errors.

    |Provider| version|
    |-|-|
    | GCP | 4.1.0 |
    | AWS | 3.65.0 |
    | Azure | 2.85.0 |

### Features
- #70 : `GCP` Add NAT router configuration also for Ops Manager.
- #64 : `Azure` fix subnet reserved ranges.
- #63 : `All Providers` Inconsistent DNS A record entries for PKS API endpoints.
- `All Providers` : All the version constraints for the providers were moved to the `version.tf` files.
- `Azure`: Updated the `azurerm_subnet` resources to use the new `address_prefixes` property.
- `Azure`: Fixed an interpolation warning on `azure/ops-manager-resource-groups.tf`.
- `Azure` : Removed the property `enable_advanced_thread_protection` from the `azurerm_storage_account` resource, which was removed on the latest version of the provider.
- `Azure` : Added resourcce `azurerm_advanced_thread_protection` which substitutes the use of the property `enable_advanced_thread_protection` on the `azurerm_storage_account` resources.
- `Azure` : Added the property `allow_blob_public_access` with value `true` on the `azurerm_storage_account.bosh` resource, this should mimic previous behavior which was throwing errors after the provider upgrade.
- `Azure` : Changed the value of the `role_definition_id` of the `azurerm_role_assignment` resources to use the `azurerm_role_definition.resource_name.resource` property instead of `azurerm_role_definition.pks-worker.id`, this fixes a problem introduced after upgrading the provider, caused by a change on the format on the property `id` for the `azurerm_role_definition`.
- `Azure` : Removed the use of the propert `resource_group_name` on the `azurerm_lb_backend_address_pool` resources.
- `Azure` : Updated the `azurerm_lb_probe` resources to use the property `backend_address_pool_ids` instead of the property `backend_address_pool_id`, this removes a deprecation warning.
- `GCP`: Added propert `source_ranges` to firewall rules which didn't had it, this setting can be change using the `ingress_source_ranges` variable on the `terraform.tfvars` file.

### Bug Fixes
- Fixed an issue introduced by [fc36573](https://github.com/pivotal/paving/fc36573) which caused the terraform to fail on certain circumstances.

## 2.1.0

### Features
- [47539b2](https://github.com/pivotal/paving/47539b2) - Add an override to use http2 in gcp load balancer
- [0e5e31c](https://github.com/pivotal/paving/0e5e31c) - Add note about the environment FQDN
- [c8d8eb4](https://github.com/pivotal/paving/c8d8eb4) - Update example.tfvars for GCP to be more clear
- [5cb3ce3](https://github.com/pivotal/paving/5cb3ce3) - Add a prerequisite to paving GCP
- [fc36573](https://github.com/pivotal/paving/fc36573) - Generate list of backends dynamically in the PAS lb
- [1691aea](https://github.com/pivotal/paving/1691aea) - adding api prefix to the configuration value
- [ff21c1c](https://github.com/pivotal/paving/ff21c1c) - Create ssl certificate before destroying it so certs can be rotated

### Bug Fixes
- [8bd00d7](https://github.com/pivotal/paving/8bd00d7) - Restrict Google Platform Provider to v3.90 patch releases, this fixes a breaking change present on `v4.00` of the `gcp` provider.

## 2.0.0

### Features
* Updated to terraform v0.13.0 HCL formatting.

### Breaking Changes
* When using `paving` for creating a foundation,
  there are instances provisioned that may not be used.
  For example, only deploying Ops Manager and PAS tile,
  but still having networking resources created for PKS.

  This update allows control over that.
  The terraform resources have been organized into namespaced files.
  The namespacing identifies the resources and what they are for.
  For example, `pas-iam.tf` creates IAM resources for PAS tile.
  There are corresponding namespaces for `ops-manager-*.tf` and `pks-*.tf`.

  If you don't require PAS, run `rm pas-*.tf`.
  If you don't require PKS, run `rm pks-*.tf`.

  OpsManager resources cannot be removed as Ops Manager is required.

  This change also affects the `stable_config` pattern of outputs.
  Because there is no way to test the existence of a resource in `terraform`,
  `stable_config` has to be separated by Ops Manager `stable_config_opsmanager`,
  PAS `stable_config_pas`, and PKS `stable_config_pks`.
  
  These changes are on all IAASes.
  NOTE: `nsxt` does not have paving resources for PKS, which is why prefixed files are not there.

## 1.0.0

### Features
* AWS, GCP, and Azure includes resources to pave Ops Manager, PAS, and PKS.
* NSX-T include includes resources to pave Ops Manager and PAS.
