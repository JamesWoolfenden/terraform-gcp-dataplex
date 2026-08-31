# The default egress route is deleted on network creation, so Dataplex tasks
# reach Google APIs (Artifact Registry, GCS, Dataproc) over the private VIP
# only. Private Google Access is enabled on the subnetwork.
resource "google_compute_route" "private_google_apis" {
  name             = "dataplex-private-google-apis"
  network          = google_compute_network.dataplex.self_link
  dest_range       = "199.36.153.8/30"
  next_hop_gateway = "default-internet-gateway"
  priority         = 1000
}
