resource "google_service_account" "dataplex" {
  account_id   = "dataplex-tasks"
  display_name = "Dataplex task execution service account"
}
