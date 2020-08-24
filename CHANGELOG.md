# Changelog

## 2.0.0

### Features
* Updated to terraform v0.13.0 HCL formatting.

### Breaking Changes
* When using `paving` for creating a foundation,
  there are instances of provisioned that may not be used.
  For example, only deploying Ops Manager and PAS tile,
  but still have networking resources created for PKS.

  This update allows control over that.
  The terraform resource have been organized into namespaced files.
  The namespacing identifies the resources and what they are for.
  For example, `pas-iam.tf` creates IAM resources for PAS tile.
  There are corresponding namespaces for `ops-manager-*.tf` and `pks-*.tf`.

  If you don't require PAS, to `rm pas-*.tf`.
  If you don't require PKS, to `rm pks-*.tf`.

  OpsManager resources cannot be removed as Ops Manager is required.

  This change also affects the `stable_config` pattern of outputs.
  Because of a limitation of `terraform`, no way to test the existence of a resource,
  `stable_config` has to be separated by Ops Manager `stable_config_opsmanager`, PAS `stable_config_pas`, and PKS `stable_config_pks`.
  
  These changes are on all IAASes.
  NOTE: `nsxt` does not have paving resources for PKS, which is why prefixed files are not there.

## 1.0.0

### Features
* AWS, GCP, and Azure includes resources to pave Ops Manager, PAS, and PKS.
* NSX-T include includes resources to pave Ops Manager and PAS.
