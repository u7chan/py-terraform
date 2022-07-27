locals {
  region_name = var.aws_region
  lambda_name        = var.lambda_name
  lambda_role        = var.lambda_role
}

provider "aws" {
  region = local.region_name
}

data "archive_file" "function_main_source" {
  type        = "zip"
  source_dir  = "src"
  output_path = "dist/${local.lambda_name}"
}

resource "aws_lambda_function" "function_main" {
  function_name = local.lambda_name
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
  role          = local.lambda_role

  filename         = data.archive_file.function_main_source.output_path
  source_code_hash = data.archive_file.function_main_source.output_base64sha256
}