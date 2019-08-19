variable "project" {
  type    = "string"
  default = "backup-s3-fndiaz"
}

variable "gcp_region" {
  type    = "string"
  default = "us-central1"
}

variable "gcp_zone" {
  type    = "string"
  default = "us-central1-c"
}

variable "aws_region" {
  type    = "string"
  default = "sa-east-1"
}

variable "aws_s3_bucket" {
  type    = "string"
  default = "logs-applications"
}

variable "gcp_storage_bucket" {
  type    = "string"
  default = "logs-applications"
}

variable "buckets" {
  default = ["logs-applications", "fndiaz-bkt"]
}
