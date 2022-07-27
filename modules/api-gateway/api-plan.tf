locals {
  plan_name = var.api_plan_name
}

resource "aws_api_gateway_usage_plan" "api_main" {
  name = local.plan_name

  api_stages {
    api_id = aws_api_gateway_rest_api.api_main.id
    stage  = aws_api_gateway_stage.prod.stage_name
  }
}
