provider "aws" {
  region = var.aws_region
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
  name               = "terraform-iam-for-lambda"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}

resource "aws_iam_role" "iam_for_api_gateway" {
  name               = "terraform-iam-for-api-gateway"
  assume_role_policy = data.aws_iam_policy_document.policy.json
}