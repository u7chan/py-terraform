variable "aws_region" {
  default = "ap-northeast-1"
}

variable "role_name_for_lambda" {
  default = "py-terraform-role-lambda"
}

variable "policy_name_for_lambda" {
  default = "py-terraform-policy-lambda"
}

variable "template_policy_for_lambda" {
  default = "./lambda_policy.tpl.json"
}

variable "role_name_for_api_gateway" {
  default = "py-terraform-role-api_gateway"
}

variable "policy_name_for_api_gateway" {
  default = "py-terraform-policy-api_gateway"
}

variable "template_policy_for_api_gateway" {
  default = "./api-gateway_policy.tpl.json"
}

