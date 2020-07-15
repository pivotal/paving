# GCP

Follow [these instructions](https://docs.pivotal.io/platform/ops-manager/2-8/gcp/prepare-env-terraform.html)
to create the service account that is needed to run the terraform templates.

### Roles & Permissions

If you are looking to create a service account with more restrictive permissions,
you can follow these instructions.

The roles required:
- Compute Instance Admin (v1) - `compute.instanceAdmin`
- Compute Network Admin - `compute.networkAdmin`
- Compute Security Admin - `compute.securityAdmin`
- DNS Administrator - `dns.admin`
- Security Admin - `iam.securityAdmin`
- Service Account Admin - `iam.serviceAccountAdmin`
- Service Account Key Admin - `iam.serviceAccountKeyAdmin`
- Storage Admin - `storage.admin`
- Service Account User - `iam.serviceAccountUser`

For each role, you can run the following command:

```console
gcloud projects add-iam-policy-binding $PROJECT_ID --member serviceAccount:$SERVICE_ACCOUNT_EMAIL --role "roles/$ROLE"
```

To understand the mapping between permissions and roles, you can see [this document](https://cloud.google.com/iam/docs/understanding-roles).
