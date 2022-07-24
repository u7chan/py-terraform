locals {
  role_api_gateway_name   = var.role_name_for_api_gateway
  policy_api_gateway_name = var.policy_name_for_api_gateway
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
  template = file("./api-gateway_policy.tpl.json")

  vars = {
    region = "${local.region_name}"
  }
}

resource "aws_iam_policy" "api_gateway" {
  name   = local.policy_api_gateway_name
  policy = data.template_file.api_gateway.rendered
}

resource "aws_iam_role" "api_gateway" {
  name               = local.role_api_gateway_name
  assume_role_policy = data.aws_iam_policy_document.api_gateway.json
}
