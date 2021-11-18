# Maintainer/Contributor Guidelines for this repository

This guide is intended for maintaners,

## CI

- The pipelines run on an internal deployment of Concourse.

- The script to update the pipelines is called `ci/scripts/update-ci.sh` and its called using a preconfigured concourse target.

## PRs

- We recommend that any feature requests / bug fixes be submitted as PRs. We recommend that when individuals
submit PRs, they have read the [Decisions](README.md#decisions) section of the readme in order to determine whether or not
the functionality they are requesting is generic and minimal enough to be added. If not, it is recommended
that this functionality live in a separate repository.

## Cutting a release

- Update the [CHANGELOG.md](CHANGELOG.md) file.
- Create a new tag with the version number and pointing to the commit with the latest change introduced.
- Create a release.
