locals {
  stage_name = var.api_stage_name
}

resource "aws_api_gateway_deployment" "api_main" {
  rest_api_id = aws_api_gateway_rest_api.api_main.id

  depends_on = [
    aws_api_gateway_integration.api_get_example
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = local.stage_name
  rest_api_id   = aws_api_gateway_rest_api.api_main.id
  deployment_id = aws_api_gateway_deployment.api_main.id
}
