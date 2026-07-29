# Creation order is derived from resource references, not file order:
# because the main queue references the DLQ ARN, Terraform creates the
# DLQ first (implicit dependency graph).
resource "aws_sqs_queue" "onboarding_events_dlq" {
  name = "onboarding-events-dlq"
}

resource "aws_sqs_queue" "onboarding_events" {
  name = "onboarding-events"

  # A message received maxReceiveCount times without successful processing
  # is moved automatically to the DLQ.
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.onboarding_events_dlq.arn
    maxReceiveCount     = 3
  })
}
