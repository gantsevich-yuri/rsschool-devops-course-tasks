variable "aws_region" {
  description = "My AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "bucket_name" {
  description = "My S3 bucket for Terraform state"
  type        = string
  default     = "my-terraform-state-bucket-00101"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table"
  type        = string
  default     = "my-terraform-state-table-00101"
}

variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB"
  type        = string
  default     = "LockID"
}