# DynamoDB is schemaless: only key attributes are declared at table level.
# All remaining merchant attributes (legal_name, pricing, status, ...) are
# written per item by the Lambdas and never appear in this definition.
resource "aws_dynamodb_table" "merchants" {
  name         = "merchants"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "merchant_id"

  attribute {
    name = "merchant_id"
    type = "S"
  }
}
