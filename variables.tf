variable "aws_region" {
  description = "My AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "My S3 bucket for Terraform state"
  type        = string
  default     = "my_terraform_state_bucket"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table"
  type        = string
  default     = "my_terraform_state_table"
}

variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB"
  type        = string
  default     = "my-terrstate-hash-00100"
}