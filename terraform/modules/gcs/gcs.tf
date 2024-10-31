# ----------------------------------------------------------------------------------------------------------------------
# GCS Bucket
# ----------------------------------------------------------------------------------------------------------------------
resource "google_storage_bucket" "bucket" {
  name =  format("%s-%s", var.project_id, var.gcs-bucket-name)
  uniform_bucket_level_access = true
  location = var.gcs-location
}