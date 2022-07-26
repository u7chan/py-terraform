locals {
  iam_api_gateway_role            = var.role_name_for_api_gateway
  iam_api_gateway_policy          = var.policy_name_for_api_gateway
  iam_api_gateway_attach          = "${var.policy_name_for_api_gateway}_attach"
  iam_api_gateway_template_policy = var.template_policy_for_api_gateway
}

data "aws_iam_policy_document" "api_gateway" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["apigateway.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}

data "template_file" "api_gateway" {
  template = file(local.iam_api_gateway_template_policy)

  vars = {
    region = "${local.region_name}"
  }
}

resource "aws_iam_policy" "api_gateway" {
  name   = local.iam_api_gateway_policy
  policy = data.template_file.api_gateway.rendered
}

resource "aws_iam_role" "api_gateway" {
  name               = local.iam_api_gateway_role
  assume_role_policy = data.aws_iam_policy_document.api_gateway.json
}

resource "aws_iam_policy_attachment" "api_gateway" {
  name       = local.iam_api_gateway_attach
  policy_arn = aws_iam_policy.api_gateway.arn
  roles = [
    aws_iam_role.api_gateway.name
  ]
}