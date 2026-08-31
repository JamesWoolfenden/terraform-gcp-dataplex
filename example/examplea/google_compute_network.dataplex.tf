resource "google_compute_network" "dataplex" {
  name                            = "dataplex-network"
  auto_create_subnetworks         = false
  delete_default_routes_on_create = true
}
