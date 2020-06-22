# AWS

Follow [these instructions](https://docs.pivotal.io/platform/ops-manager/2-8/aws/prepare-env-terraform.html)
to create an IAM user that is needed to run the terraform templates.

The above instructions specify manual steps for creating the IAM user. If you have the `aws` cli,
you can follow these steps:

```console
$ export AWS_IAM_POLICY_DOCUMENT=/tmp/policy-document.json

$ echo '{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:*",
                "elasticloadbalancing:*",
                "iam:*",
                "route53:*",
                "s3:*"
            ],
            "Resource": "*"
        }
    ]
}' > $AWS_IAM_POLICY_DOCUMENT

$ export AWS_IAM_USER_NAME="REPLACE-ME"

$ aws iam create-user --user-name $AWS_IAM_USER_NAME

$ aws iam put-user-policy --user-name $AWS_IAM_USER_NAME \
	--policy-name "policy" \
	--policy-document file://$AWS_IAM_POLICY_DOCUMENT

$ aws iam create-access-key --user-name $AWS_IAM_USER_NAME
```
