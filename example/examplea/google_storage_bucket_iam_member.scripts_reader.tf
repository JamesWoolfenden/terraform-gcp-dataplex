# The task reads its PySpark script from the scripts bucket.
resource "google_storage_bucket_iam_member" "scripts_reader" {
  bucket = google_storage_bucket.scripts.name
  role   = "roles/storage.objectViewer"
  member = "serviceAccount:${google_service_account.dataplex.email}"
}
