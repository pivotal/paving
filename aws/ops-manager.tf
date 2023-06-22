resource "aws_eip" "ops-manager" {
  vpc = true

  tags = merge(
    var.tags,
    { "Name" = "${var.environment_name}-ops-manager-eip" },
  )
}

resource "aws_key_pair" "ops-manager" {
  key_name   = "${var.environment_name}-ops-manager-key"
  public_key = tls_private_key.ops-manager.public_key_openssh
}

resource "tls_private_key" "ops-manager" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "aws_iam_instance_profile" "ops-manager" {
  name = "${var.environment_name}-ops-manager"
  role = var.cloudgate_opsman_role_name

  lifecycle {
    ignore_changes = [name]
  }
}

// NOTE: here because it gets consumed by the opsmanager policy
data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
