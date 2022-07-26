output "lambda_role" {
  value = aws_iam_role.lambda.arn
}

output "api-gateway_role" {
  value = aws_iam_role.api_gateway.arn
}

