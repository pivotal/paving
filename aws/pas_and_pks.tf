resource "aws_iam_access_key" "ops-manager-access-key" {
  user = aws_iam_user.ops-manager.name
}

resource "aws_iam_user" "ops-manager" {
  name = "${var.environment_name}-ops-manager"
}

resource "aws_iam_user_policy" "ops-manager" {
  name = "${var.environment_name}-ops-manager-policy"
  user = aws_iam_user.ops-manager.name

  policy = data.template_file.ops-manager.rendered
}

data "template_file" "ops-manager" {
  template = file("ops-manager-iam-policy.json")

  vars = {
    environment_name = var.environment_name
  }
}
