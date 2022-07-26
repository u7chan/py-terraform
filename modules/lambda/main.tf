locals {
  lambda_region_name = var.aws_region
  lambda_name        = var.lambda_name
}

provider "aws" {
  region = local.lambda_region_name
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
  role          = "arn:aws:iam::436969723105:role/py-terraform-role-lambda" #aws_iam_role.lambda.arn

  filename         = data.archive_file.function_main_source.output_path
  source_code_hash = data.archive_file.function_main_source.output_base64sha256
}