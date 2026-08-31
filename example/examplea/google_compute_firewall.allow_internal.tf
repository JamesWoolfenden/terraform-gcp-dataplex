# Dataproc Serverless, which backs Dataplex tasks, requires an ingress rule
# permitting all internal traffic between the workload's own subnetwork ranges.
resource "google_compute_firewall" "allow_internal" {
  name        = "dataplex-allow-internal"
  network     = google_compute_network.dataplex.self_link
  description = "Allow internal traffic required by Dataproc Serverless"
  direction   = "INGRESS"
  priority    = 1000

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [local.subnet_cidr]

  log_config {
    metadata = "INCLUDE_ALL_METADATA"
  }
}
