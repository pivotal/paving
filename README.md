# Paving

This repository contains Terraform templates for paving the necessary
infrastructure to deploy Tanzu application Platform (PKS and TAS) to a single foundation.
The templates support AWS, vSphere, Azure, and GCP.


## Requirements
As of `v3.0.0` of this repository the following are the supported versions of the `Terraform CLI` and providers:

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

The terraform templates are namespaced for the resources that consume them.
In each IAAS, the prefix `opsmanager-`, `pks-`, and `pas-` are on the file names.

There are cases that some resources aren't required in a foundation.
For example, just deploying PKS and not PAS.
To remove PAS resources, just `rm pas-*.tf` the file from the directory.

Please note that the `opsmanager-*.tf` files cannot be removed.
Every foundation requires an Ops Manager.

## Decisions

- These templates support deploying Tanzu Application Service (TAS)
and Pivotal Container Service (PKS) to the same foundation.

- The templates **do not** create an Ops Manager VM but **do**
create the necessary infrastructure for the VM (security groups, keys, etc).

- These templates demonstrate a modest production deployment in three (3) AZs on each IaaS.

- These templates contain extremely minimal interdependence or cleverness, to facilitate incorporating these templates into your own automation easily.

## Versioning

The semantics of the versioning of paving's releases are based on the contents
of `terraform output stable_config_(opsmanager|pas|pks)`. `stable_config` should always represent
the minimum necessary to install Pivotal Platform. Any other output may be
added or removed without a change in version. However, MAJOR.MINOR.PATCH should
change according to the following:
- If an output is removed or a major breaking change is introduced, the MAJOR version should be incremented
- If an output is added, the MINOR version should be incremented
- Otherwise, the patch version should be incremented

## Customization

### Jumpbox

In our current configuration, we are using the Ops Manager VM as the
jumpbox. The Ops Manager VM is deployed in the public subnet with a
configuration (`var.ops_manager_allowed_ips`) to restrict it by IP. If you want to use a
jumpbox instead, you may deploy ops manager in the management subnet.
