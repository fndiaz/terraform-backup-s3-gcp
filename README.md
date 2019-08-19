
## Backup S3 to GCP

Sync S3 bucket with Google Storage bucket

Define Bukcets to backup in List - variables.tf

```
variable "buckets" {
  default = ["bucket1", "bucket2"]
}
```

Backup differential of all files runs daily 
