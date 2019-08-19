provider "google" {
  credentials = "${file("gcp.json")}"
  region      = "${var.gcp_region}"
  zone        = "${var.gcp_zone}"
}

provider "aws" {
  region = "${var.aws_region}"
}
