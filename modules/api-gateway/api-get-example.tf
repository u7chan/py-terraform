locals {
  name       = var.api_get_example
  lambda_arn = var.lambda_arn
  role       = var.api_gateway_role
}

resource "aws_api_gateway_resource" "api_get_example" {
  rest_api_id = aws_api_gateway_rest_api.api_main.id
  parent_id   = aws_api_gateway_rest_api.api_main.root_resource_id
  path_part   = local.name
}

resource "aws_api_gateway_method" "api_get_example" {
  rest_api_id      = aws_api_gateway_rest_api.api_main.id
  resource_id      = aws_api_gateway_resource.api_get_example.id
  http_method      = "GET"
  authorization    = "NONE"
  api_key_required = true // Use API Key 
}

resource "aws_api_gateway_method_response" "api_get_example" {
  rest_api_id = aws_api_gateway_rest_api.api_main.id
  resource_id = aws_api_gateway_resource.api_get_example.id
  http_method = aws_api_gateway_method.api_get_example.http_method
  status_code = "200"

  response_models = {
    "application/json" = "Empty"
  }

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration" "api_get_example" {
  rest_api_id             = aws_api_gateway_rest_api.api_main.id
  resource_id             = aws_api_gateway_resource.api_get_example.id
  http_method             = aws_api_gateway_method.api_get_example.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = local.lambda_arn // Lambda ARN
  credentials             = local.role       // IAM API Gateway ARN
}

resource "aws_api_gateway_integration_response" "api_get_example" {
  depends_on = [
    "aws_api_gateway_integration.api_get_example"
  ]

  rest_api_id = aws_api_gateway_rest_api.api_main.id
  resource_id = aws_api_gateway_resource.api_get_example.id
  http_method = aws_api_gateway_method.api_get_example.http_method
  status_code = aws_api_gateway_method_response.api_get_example.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
    "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}