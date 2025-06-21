variable "aws_region" {
  description = "My AWS region"
  type        = string
  default     = "eu-central-1"
}

variable "azs" {
  type        = list(string)
  description = "List of availability zones for the region"
  default     = ["eu-central-1a", "eu-central-1b"]
}

variable "bucket_name" {
  description = "My S3 bucket for Terraform state"
  type        = string
  default     = "my-terraform-state-bucket-00100"
}

variable "dynamodb_table_name" {
  description = "DynamoDB table"
  type        = string
  default     = "my-terraform-state-table-00100"
}

variable "dynamodb_hash_key" {
  description = "Hash key for the DynamoDB"
  type        = string
  default     = "LockID"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets"
  default     = ["10.0.11.0/24", "10.0.21.0/24"]
}