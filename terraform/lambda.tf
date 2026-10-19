# archive_file only zips what already exists on disk: dependencies must be
# installed into the package directory BEFORE running plan/apply
# (uv pip install --target lambdas/spike/package pydantic).
data "archive_file" "spike" {
  type        = "zip"
  source_dir  = "${path.module}/../lambdas/spike/package"
  output_path = "${path.module}/.build/spike.zip"
}

resource "aws_lambda_function" "spike" {
  function_name = "spike"
  role          = aws_iam_role.lambda_exec.arn
  runtime       = "python3.12"
  handler       = "handler.lambda_handler"

  filename         = data.archive_file.spike.output_path
  source_code_hash = data.archive_file.spike.output_base64sha256
}
