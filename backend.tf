terraform {
  required_version = "= 0.12.6"

  backend "s3" {
    bucket = "fndiaz-terraform-status"
    key    = "backup-s3/iam/state"
    region = "us-east-1"
  }
}
