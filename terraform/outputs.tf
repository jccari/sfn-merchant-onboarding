# Public interface of this root module. Consumed in later milestones to
# inject resource identifiers into the ASL state machine template and by
# the end-to-end acceptance scripts.
output "merchants_table_name" {
  value = aws_dynamodb_table.merchants.name
}

output "onboarding_events_queue_url" {
  value = aws_sqs_queue.onboarding_events.url
}

output "onboarding_events_dlq_url" {
  value = aws_sqs_queue.onboarding_events_dlq.url
}
