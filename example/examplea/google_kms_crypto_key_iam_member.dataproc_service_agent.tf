# With a CMEK set on the task, Dataproc Serverless uses its service agent to
# encrypt batch job arguments and the staging bucket data with the key.
resource "google_kms_crypto_key_iam_member" "dataproc_service_agent" {
  crypto_key_id = google_kms_crypto_key.dataplex.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_project_service_identity.dataproc.email}"
}
