locals {
  iam_lambda_role            = var.role_name_for_lambda
  iam_lambda_policy          = var.policy_name_for_lambda
  iam_lambda_attach          = "${var.policy_name_for_lambda}_attach"
  iam_lambda_template_policy = var.template_policy_for_lambda
}

data "aws_iam_policy_document" "lambda" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "template_file" "lambda" {
  template = file(local.iam_lambda_template_policy)

  vars = {
    region = "${local.iam_region_name}"
  }
}

resource "aws_iam_policy" "lambda" {
  name   = local.iam_lambda_policy
  policy = data.template_file.lambda.rendered
}

resource "aws_iam_role" "lambda" {
  name               = local.iam_lambda_role
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_policy_attachment" "lambda" {
  name       = local.iam_lambda_attach
  policy_arn = aws_iam_policy.lambda.arn
  roles = [
    aws_iam_role.lambda.name
  ]
}
