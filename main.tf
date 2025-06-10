provider "aws" {
  region = var.aws_region
  version = "~> 5.0"
  source  = "hashicorp/aws"
}

module "s3_bucket" {
  source = "./s3"
  bucket_name = var.bucket_name
}

module "dynamodb_table" {
  source = "./dynamodb"
  table_name = var.dynamodb_table_name
  hash_key   = var.dynamodb_hash_key
}
