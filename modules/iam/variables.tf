variable "aws_region" {
  default = "ap-northeast-1"
}

variable "role_name_for_lambda" {
  default = "py-terraform-role-lambda"
}

variable "policy_name_for_lambda" {
  default = "py-terraform-policy-lambda"
}

variable "role_name_for_api_gateway" {
  default = "py-terraform-role-api_gateway"
}

variable "policy_name_for_api_gateway" {
  default = "py-terraform-policy-lambda"
}
