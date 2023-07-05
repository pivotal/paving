data "aws_iam_policy_document" "pas-blobstore-policy" {
  statement {
    sid     = "PasBlobstorePolicy"
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

resource "aws_iam_policy" "pas-blobstore" {
  name   = "${var.environment_name}-pas-blobstore-policy"
  policy = data.aws_iam_policy_document.pas-blobstore-policy.json
}

resource "aws_iam_role_policy_attachment" "pas-blobstore" {
  role       = aws_iam_role.pas-blobstore.name
  policy_arn = aws_iam_policy.pas-blobstore.arn
}

resource "aws_iam_instance_profile" "pas-blobstore" {
  name = "${var.environment_name}-pas-blobstore"
  role = aws_iam_role.pas-blobstore.name

  lifecycle {
    ignore_changes = [name]
  }
}
