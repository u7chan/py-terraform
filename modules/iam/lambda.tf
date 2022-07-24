locals {
  role_lambda_name   = var.role_name_for_lambda
  policy_lambda_name = var.policy_name_for_lambda
  attach_lambda_name = "${var.policy_name_for_lambda}_attach"
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
  template = file("./lambda_policy.tpl.json")

  vars = {
    region = "${local.region_name}"
  }
}

resource "aws_iam_policy" "lambda" {
  name   = local.policy_lambda_name
  policy = data.template_file.lambda.rendered
}

resource "aws_iam_role" "lambda" {
  name               = local.role_lambda_name
  assume_role_policy = data.aws_iam_policy_document.lambda.json
}

resource "aws_iam_policy_attachment" "lambda" {
  name       = local.attach_lambda_name
  policy_arn = aws_iam_policy.lambda.arn
  roles = [
    aws_iam_role.lambda.name
  ]
}
