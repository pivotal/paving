# Paving

Terraform templates for paving Pivotal Platform on AWS, vSphere, Azure, and (maybe) GCP.

These templates are configured such that you can deploy
Pivotal Application Service (PAS) and Pivotal Container
Service (PKS) to the same foundation.

## Usage

## Conventions

These templates demonstrate a modest production deployment in two AZs on each IaaS. They contain extremely minimal interdependence or cleverness, to facilitate incorporating these templates into your own automation easily.

## Versioning

The semantics of the versioning of paving's releases are based on the contents of `terraform output stable_config`. `stable_config` should always represent the minimum necessary to install Pivotal Platform. Any other output may be added or removed without a change in version. However, MAJOR.MINOR.PATCH should change according to the following:
- If an output is removed, the MAJOR version should be incremented
- If an output is added, the MINOR version should be incremented
- Otherwise, the patch version should be incremented

## Customization

### Jumpbox

We demonstrate using the Ops Manager VM as the jumpbox, and therefore deploy it
in the public subnet with a ALLOWED_IPS varible to restrict it by IP. If you want to use a
jumpbox instead, you may deploy ops manager in the management subnet.

### Isolation Segments
