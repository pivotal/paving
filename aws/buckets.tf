resource "aws_s3_bucket" "ops-manager-bucket" {
  bucket = "${var.environment_name}-ops-manager-bucket"

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-ops-manager-bucket" },
  )
}

resource "aws_s3_bucket" "buildpacks-bucket" {
  bucket = "${var.environment_name}-buildpacks-bucket"

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-buildpacks-bucket" },
  )
}

resource "aws_s3_bucket" "packages-bucket" {
  bucket = "${var.environment_name}-packages-bucket"

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-packages-bucket" },
  )
}

resource "aws_s3_bucket" "resources-bucket" {
  bucket = "${var.environment_name}-resources-bucket"

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-resources-bucket" },
  )
}

resource "aws_s3_bucket" "droplets-bucket" {
  bucket = "${var.environment_name}-droplets-bucket"

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-droplets-bucket" },
  )
}
