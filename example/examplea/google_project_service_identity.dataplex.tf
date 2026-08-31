resource "google_project_service_identity" "dataplex" {
  provider = google-beta
  service  = "dataplex.googleapis.com"
}
