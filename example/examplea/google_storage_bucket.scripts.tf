# holden:ignore:HLD_GCP_003 — example bucket, access logging target is out of scope
resource "google_storage_bucket" "scripts" {
  name                        = "example-dataplex-scripts"
  location                    = "europe-west2"
  force_destroy               = false
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  encryption {
    default_kms_key_name = google_kms_crypto_key.dataplex.id
  }

  versioning {
    enabled = true
  }

  soft_delete_policy {
    retention_duration_seconds = 604800
  }

  lifecycle_rule {
    condition {
      age = 365
    }

    action {
      type = "Delete"
    }
  }

  depends_on = [google_kms_crypto_key_iam_member.gcs_service_agent]
}
