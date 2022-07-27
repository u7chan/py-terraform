locals {
  region_name = var.aws_region
  name        = var.lambda_name
  role        = var.lambda_role
}

provider "aws" {
  region = local.region_name
}

data "archive_file" "function_main_source" {
  type        = "zip"
  source_dir  = "src"
  output_path = "dist/${local.name}"
}

resource "aws_lambda_function" "function_main" {
  function_name = local.name
  handler       = "main.lambda_handler"
  runtime       = "python3.9"
  role          = local.role

  filename         = data.archive_file.function_main_source.output_path
  source_code_hash = data.archive_file.function_main_source.output_base64sha256
}