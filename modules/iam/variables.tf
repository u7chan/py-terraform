variable "iam_for_lambda" {
  default     = "py-terraform-role-lambda"
  description = "name"
}

variable "iam_for_api_gateway" {
  default     = "py-terraform-role-api_gateway"
  description = "name"
}