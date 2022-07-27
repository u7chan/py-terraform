locals {
  region_name = var.aws_region
  api_name    = var.api_gateway_name
}

provider "aws" {
  region = local.region_name
}

resource "aws_api_gateway_rest_api" "api_main" {
  name = local.api_name
}