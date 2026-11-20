# Dataproc Serverless encrypts the batch's persistent disks with the CMEK; the
# Compute Engine service agent performs those calls. It exists once the Compute
# Engine API is enabled, which the network resources in this example require.
data "google_project" "current" {}

resource "google_kms_crypto_key_iam_member" "compute_service_agent" {
  crypto_key_id = google_kms_crypto_key.dataplex.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:service-${data.google_project.current.number}@compute-system.iam.gserviceaccount.com"
}
