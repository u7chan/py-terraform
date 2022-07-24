locals {
  lambda_name = var.iam_for_lambda
  api_gateway = var.iam_for_api_gateway
}

data "aws_iam_policy_document" "policy" {
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

resource "aws_iam_role" "iam_for_lambda" {
  name               = local.lambda_name
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role" "iam_for_api_gateway" {
  name               = local.api_gateway
  assume_role_policy = data.aws_iam_policy_document.policy.json
}