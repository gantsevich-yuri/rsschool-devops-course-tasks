terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket-00101"
    key            = "terraform/state.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "my-terraform-state-table-00101"
  }
}