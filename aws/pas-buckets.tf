resource "random_integer" "pas_bucket_suffix" {
  min = 1
  max = 100000
}

resource "aws_s3_bucket" "buildpacks-bucket" {
  bucket = "${var.environment_name}-buildpacks-bucket-${random_integer.pas_bucket_suffix.result}"

  versioning {
    enabled = true
  }

  tags = merge(
  var.tags,
  { "Name" = "${var.environment_name}-buildpacks-bucket-${random_integer.pas_bucket_suffix.result}" },
  )
}

resource "aws_s3_bucket" "packages-bucket" {
  bucket = "${var.environment_name}-packages-bucket-${random_integer.pas_bucket_suffix.result}"

  versioning {
    enabled = true
  }

  tags = merge(
  var.tags,
  { "Name" = "${var.environment_name}-packages-bucket-${random_integer.pas_bucket_suffix.result}" },
  )
}

resource "aws_s3_bucket" "resources-bucket" {
  bucket = "${var.environment_name}-resources-bucket-${random_integer.pas_bucket_suffix.result}"

  versioning {
    enabled = true
  }

  tags = merge(
  var.tags,
  { "Name" = "${var.environment_name}-resources-bucket-${random_integer.pas_bucket_suffix.result}" },
  )
}

resource "aws_s3_bucket" "droplets-bucket" {
  bucket = "${var.environment_name}-droplets-bucket-${random_integer.pas_bucket_suffix.result}"

  versioning {
    enabled = true
  }

  tags = merge(
  var.tags,
  { "Name" = "${var.environment_name}-droplets-bucket-${random_integer.pas_bucket_suffix.result}" },
  )
}
