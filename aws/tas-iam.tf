data "aws_iam_policy_document" "tas-blobstore-policy" {
  statement {
    sid     = "TasBlobstorePolicy"
    effect  = "Allow"
    actions = ["s3:*"]
    resources = [
      aws_s3_bucket.buildpacks-bucket.arn,
      "${aws_s3_bucket.buildpacks-bucket.arn}/*",
      aws_s3_bucket.packages-bucket.arn,
      "${aws_s3_bucket.packages-bucket.arn}/*",
      aws_s3_bucket.resources-bucket.arn,
      "${aws_s3_bucket.resources-bucket.arn}/*",
      aws_s3_bucket.droplets-bucket.arn,
      "${aws_s3_bucket.droplets-bucket.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "tas-blobstore" {
  name   = "${var.environment_name}-tas-blobstore-policy"
  policy = data.aws_iam_policy_document.tas-blobstore-policy.json
}

resource "aws_iam_role" "tas-blobstore" {
  name = "${var.environment_name}-tas-blobstore"

  lifecycle {
    create_before_destroy = true
  }

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "ec2.amazonaws.com"
        ]
      },
      "Action": [
        "sts:AssumeRole"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "tas-blobstore" {
  role       = aws_iam_role.tas-blobstore.name
  policy_arn = aws_iam_policy.tas-blobstore.arn
}

resource "aws_iam_instance_profile" "tas-blobstore" {
  name = "${var.environment_name}-tas-blobstore"
  role = aws_iam_role.tas-blobstore.name

  lifecycle {
    ignore_changes = [name]
  }
}
