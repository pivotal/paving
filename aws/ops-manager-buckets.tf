resource "random_integer" "ops_manager_bucket_suffix" {
  min = 1
  max = 100000
}

resource "aws_s3_bucket" "ops-manager-bucket" {
  bucket = "${var.environment_name}-ops-manager-bucket-${random_integer.ops_manager_bucket_suffix.result}"

  versioning {
    enabled = true
  }

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-ops-manager-bucket-${random_integer.ops_manager_bucket_suffix.result}" },
  )
}
