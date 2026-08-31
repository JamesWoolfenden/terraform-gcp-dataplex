resource "google_kms_key_ring" "dataplex" {
  name     = "dataplex-keyring"
  location = "europe-west2"
}
