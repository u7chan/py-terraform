provider "aws" {
  region = var.aws_region
}

# resource "aws_lambda_function" "main" {
#   function_name = "terrform-getUser"

#   filename         = var.file_name_get_user
#   source_code_hash = filemd5(var.file_name_get_user)

#   role    = aws_iam_role.iam_for_lambda.arn
#   handler = "getUser.getUser"
#   runtime = "nodejs16.x"
# }