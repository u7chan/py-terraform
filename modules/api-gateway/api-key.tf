locals {
  key_name = var.api_key_name
}

resource "aws_api_gateway_api_key" "api_main" {
  name = local.key_name
}

resource "aws_api_gateway_usage_plan_key" "api_main" {
  key_id        = aws_api_gateway_api_key.api_main.id
  key_type      = "API_KEY"
  usage_plan_id = aws_api_gateway_usage_plan.api_main.id
}
