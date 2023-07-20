# Paving
This repository contains Terraform templates for paving infrastructure
to deploy Tanzu application Platform (TAS)
and Tanzu Kubernetes Grid Integrated Edition (TKGi)
to a single foundation.

The templates support AWS, vSphere, Azure, and GCP.

## Requirements
As of the `v3.0.0` tag on this repo,
the following are the supported versions
of the `Terraform CLI` and providers:

- Terraform CLI `v1.0.11`
- Provider versions
    |Provider| version|
    |-|-|
    | GCP | 4.1.0 |
    | AWS | 3.65.0 |
    | Azure | 2.85.0 | 

## Usage


### Configuration

In each IaaS directory, there is a `terraform.tfvars.example` you can copy
and modify with your configuration choices and credentials.

1. `terraform init`
1. `terraform plan -var-file terraform.tfvars`
1. `terraform apply -var-file terraform.tfvars`
1. `terraform output stable_config_output`
1. `terraform destroy -var-file terraform.tfvars`

### Removing unnecessary resources

The templates are namespaced to the resources that require them.
In each IAAS, the prefix `opsmanager-`, `pks-`, and `pas-` are on the file names.
(The prefixe for TAS is `pas-`,
and the prefix for TKGi is `pks-`
for historical reasons;
these may change in a future major version.)

There are cases that some resources aren't required in a foundation.
For example, just deploying TKGi and not TAS.
To remove TAS resources, just `rm pas-*.tf` the file from the directory.

Please note that the `opsmanager-*.tf` files cannot be safely removed;
every foundation requires an Ops Manager.

## Decisions

- These templates support deploying TAS and TKGi to the same foundation.

- The templates **do not** create an Ops Manager VM but **do**
  create the necessary infrastructure for the VM (security groups, keys, etc).
  Ops Manager VM creation can be managed with
  [Platform Automation Toolkit](docs.pivotal.io/platform-automation).

- These templates demonstrate a modest production deployment in three (3) AZs on each IaaS.

- These templates contain extremely minimal interdependence or cleverness,
  to facilitate incorporating these templates into your own automation easily.

## Versioning
This repo applies Semantic Versioning;
the following is an attempt to declare the versioned API.

The semantics of the versioning of paving's releases are based on the contents
of `terraform output stable_config_(opsmanager|pas|pks)`. `stable_config` should always represent
the minimum necessary to install Pivotal Platform. Any other output may be
added or removed without a change in version. However, MAJOR.MINOR.PATCH should
change according to the following:
- If an output is removed or a major breaking change is introduced, the MAJOR version should be incremented
- If an output is added, the MINOR version should be incremented
- Otherwise, the patch version should be incremented

Addition of support for Terraform provider and CLI versions
can be done in a patch,
if it doesn't disrup the above output.
Removal of support for Terraform provider and CLI versions
calls for a Major version.

Filenames are explicitly beyond the purview of this versioning,
but we will increment the major versions if/when we update the prefixes/namespaces
used to delete unwanted resources,
and if we significantly change any of the above Decisions.

## Customization
This template should be taken as a starting place,
and treated more as documentation than as a product.

If you need to modify it to your own environment and needs,
by all means do - make a copy or a fork.

If you need to extend it in a way that is purely additive,
maintaining `.tf` files meant to be copied into place can work;
Platform Automation's documentation has an example of this
(here)[https://docs.pivotal.io/p-concourse/v7/installation/install-platform-automation/#create-the-required-iaas-infrastructure].

## Contribution
Contribution can be made by the TAS Platform Provider Experience team directly to the develop branch,
trunk-based-development style,
and then PR'd to `release` for public consumption.
Please add a version tag and update the version number in this doc
before merging to `release`.

Others may make a PR on either branch.

Keep in mind that we intend this to be
a minimal, functional, correct piece of _documentation._

While features may be valuable, maintainability and clarity are of greater importance.

### Jumpbox

The current configuration uses the the Ops Manager VM as a jumpbox.
The Ops Manager VM is deployed in the public subnet
with a configuration (`var.ops_manager_allowed_ips`) to restrict it by IP.
If you want to provision your own jumpbox instead,
you may deploy Ops Manager in the management subnet.

