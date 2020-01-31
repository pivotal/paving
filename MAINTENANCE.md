# Maintenance

## CI

- The pipelines run on an internal deployment of Concourse called [Hush-House](https://hush-house.pivotal.io).
You will need to reach out to the team that maintains HH
in order to be added to the `infrastructure` team.

- The script to update the pipelines is called `ci/reconfigure` and it uses a cli called `reconfigure-pipeline`
that uses the lastpass cli (`lpass`) to load all the credentials from secure notes into the pipeline
config files before running `fly set-pipeline` so this way no credentials are written to disk.


## PRs

- We recommend that any feature requests / bug fixes be submitted as PRs. We recommend that when individuals
submit PRs, they have read the [Decisions](README.md#decisions) section of the readme in order to determine whether or not
the functionality they are requesting is generic and minimal enough to be added. If not, it is recommended
that this functionality live in a separate repository.

## Cutting a release

- TODO
