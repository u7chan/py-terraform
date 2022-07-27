variable "aws_region" {
  default = "ap-northeast-1"
}

variable "api_gateway_name" {
  default = "py-terraform-example-api_gateway"
}

variable "api_get_example" {
  default = "get_example"
}

variable "lambda_arn" {}

variable "api_gateway_role" {}