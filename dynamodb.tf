resource "aws_dynamodb_table" "my_dyndb" {
  name         = var.dynamodb_table_name
  hash_key     = var.dynamodb_hash_key
  billing_mode = "PAY_PER_REQUEST"

  attribute {
    name = var.dynamodb_hash_key
    type = "S"
  }
}