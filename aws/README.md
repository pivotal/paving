# AWS

Create an IAM user with the following permissions for running the terraform templates.

Install the `aws` cli following [these instructions](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv1.html).

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
                "route53:*"
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
