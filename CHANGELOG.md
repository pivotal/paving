# Changelog

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
