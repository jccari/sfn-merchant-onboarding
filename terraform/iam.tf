# Floci emulates IAM, so roles are created for real. Even though no policy
# enforcement happens locally, keeping the role resource preserves the same
# shape the configuration would have against real AWS.
data "aws_iam_policy_document" "lambda_assume" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_exec" {
  name               = "lambda-exec"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume.json
}
