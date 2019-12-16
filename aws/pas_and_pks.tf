variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  version = "~> 2.0"
  region  = "us-west-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

terraform {
  required_version = ">= 0.12.0"
}

variable "environment_name" {}

resource "aws_s3_bucket" "ops-manager-bucket" {
  bucket = "${var.environment_name}-ops-manager-bucket"
}

resource "aws_s3_bucket" "buildpacks-bucket" {
  bucket = "${var.environment_name}-buildpacks-bucket"
}

resource "aws_s3_bucket" "packages-bucket" {
  bucket = "${var.environment_name}-packages-bucket"
}

resource "aws_s3_bucket" "resources-bucket" {
  bucket = "${var.environment_name}-resources-bucket"
}

resource "aws_s3_bucket" "droplets-bucket" {
  bucket = "${var.environment_name}-droplets-bucket"
}

resource "aws_iam_access_key" "ops-manager-access-key" {
  user    = aws_iam_user.ops-manager.name
}

resource "aws_iam_user" "ops-manager" {
  name = "${var.environment_name}-ops-manager"
}

resource "aws_iam_user_policy" "ops-manager-policy" {
  name = "${var.environment_name}-ops-manager-policy"
  user = aws_iam_user.ops-manager.name

  policy = data.template_file.ops_manager.rendered
}


data "template_file" "ops_manager" {
  template = file("ops-manager-iam-policy.json")

  vars = {
    environment_name = var.environment_name
  }
}
