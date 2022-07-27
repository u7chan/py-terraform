variable "aws_region" {
  default = "ap-northeast-1"
}

variable "api_gateway_name" {
  default = "py-terraform-example-api_gateway"
}

variable "api_get_example" {
  default = "get_example"
}

variable "api_stage_name" {
  default = "py-terraform-example-api_state_name"
}

variable "api_plan_name" {
  default = "py-terraform-example-api_plan"
}

variable "api_key_name" {
  default = "py-terraform-example-api_key"
}

variable "lambda_arn" {}

variable "api_gateway_role" {}