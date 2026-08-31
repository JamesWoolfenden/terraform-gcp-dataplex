resource "google_compute_subnetwork" "dataplex" {
  name                     = "dataplex-subnet"
  ip_cidr_range            = local.subnet_cidr
  region                   = "europe-west2"
  network                  = google_compute_network.dataplex.id
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}
