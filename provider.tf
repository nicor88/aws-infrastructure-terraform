# provider
provider "aws" {
  region = "us-east-1"
}

# setup S3 bucket for Remote state
resource "aws_s3_bucket" "terraform-remote-state" {
  bucket = "nicor-terraform-state"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags {
    Name = "S3 Remote Terraform State Store"
  }
}

# uncomment this section when initializing terraform
terraform {
  backend "s3" {
  encrypt = false
  bucket = "nicor-terraform-state"
  key = "terraform_state.tfstate"
 }
}
