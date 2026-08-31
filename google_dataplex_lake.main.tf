resource "google_dataplex_lake" "main" {
  name        = var.lake_name
  location    = var.location
  description = var.description

  labels = var.labels
}
