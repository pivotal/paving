# GCP

Create a user with the following IAM permissions to run the terraform templates.

Install the `gcloud` cli following [these instructions](https://cloud.google.com/sdk/docs/).

```console
$ export ACCOUNT_NAME="<REPLACE-ME>"

$ export PROJECT_ID="<REPLACE-ME>"

$ gcloud iam service-accounts create $ACCOUNT_NAME

$ gcloud iam service-accounts keys create "terraform.key.json" --iam-account "$ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com"

$ gcloud projects add-iam-policy-binding $PROJECT_ID --member 'serviceAccount:$ACCOUNT_NAME@PROJECT_ID.iam.gserviceaccount.com' --role 'roles/owner'
```
