locals {
  region_name = var.aws_region
  role_name   = var.role_name_for_lambda
  policy_name = var.policy_name_for_lambda
}

data "aws_iam_policy_document" "main" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com", "apigateway.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "template_file" "main" {
  template = file("./lambda_policy.tpl.json")

  vars = {
    region = "${local.region_name}"
  }
}

resource "aws_iam_policy" "main" {
  name   = local.policy_name
  policy = data.template_file.main.rendered
}

resource "aws_iam_role" "main" {
  name               = local.role_name
  assume_role_policy = data.aws_iam_policy_document.main.json
}
