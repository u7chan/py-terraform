locals {
  lambda_role            = var.role_name_for_lambda
  lambda_policy          = var.policy_name_for_lambda
  lambda_attach          = "${var.policy_name_for_lambda}_attach"
  lambda_template_policy = var.template_policy_for_lambda
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
  template = file(local.lambda_template_policy)

  vars = {
    region = "${local.region_name}"
  }
}

resource "aws_iam_policy" "lambda" {
  name   = local.lambda_policy
  policy = data.template_file.lambda.rendered
}

resource "aws_iam_role" "lambda" {
  name               = local.lambda_role
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_policy_attachment" "lambda" {
  name       = local.lambda_attach
  policy_arn = aws_iam_policy.lambda.arn
  roles = [
    aws_iam_role.lambda.name
  ]
}
