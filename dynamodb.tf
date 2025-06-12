resource "aws_dynamodb_table" "my_dyndb" {
  name           = var.dynamodb_table_name
  hash_key       = var.dynamodb_hash_key
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = var.dynamodb_hash_key
    type = "S"
  }
}