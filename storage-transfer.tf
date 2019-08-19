data "google_storage_transfer_project_service_account" "default" {
  project = "${var.project}"
}

resource "google_storage_bucket" "s3-backup-bucket" {
  for_each = {for name in var.buckets: name => name}
  name          = each.value
  location      = "US"
  storage_class = "COLDLINE"
  project       = "${var.project}"
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "s3-backup-bucket" {
  for_each = {for name in var.buckets: name => name}
  bucket = each.value
  role   = "roles/storage.admin"
  member = "serviceAccount:${data.google_storage_transfer_project_service_account.default.email}"

  depends_on = [
    "google_storage_bucket.s3-backup-bucket",
  ]
}

resource "google_storage_transfer_job" "s3-bucket-backup" {
  for_each = {for name in var.buckets: name => name}
  description = "Backup of S3 bucket - ${each.value}"
  project     = "${var.project}"

  transfer_spec {
    object_conditions {
      #max_time_elapsed_since_last_modification = "600s"
      exclude_prefixes = [
        "file.gz",
      ]
    }

    transfer_options {
      delete_objects_unique_in_sink = false
    }

    aws_s3_data_source {
      bucket_name = each.value

      aws_access_key {
        access_key_id     = "${aws_iam_access_key.s3-backup-ro.id}"
        secret_access_key = "${aws_iam_access_key.s3-backup-ro.secret}"
      }
    }

    gcs_data_sink {
      bucket_name = each.value
    }
  }

  schedule {
    schedule_start_date {
      year  = 2019
      month = 1
      day   = 1
    }

    schedule_end_date {
      year  = 2099
      month = 1
      day   = 1
    }

    start_time_of_day {
      hours   = 20
      minutes = 40
      seconds = 0
      nanos   = 0
    }
  }

  depends_on = [
    "google_storage_bucket_iam_member.s3-backup-bucket",
    "aws_iam_access_key.s3-backup-ro",
  ]
}
