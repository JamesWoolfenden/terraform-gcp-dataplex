# The task's container image is pulled from Artifact Registry (*.pkg.dev),
# which is also only reachable over the private.googleapis.com VIP.
resource "google_dns_managed_zone" "pkg_dev" {
  name        = "dataplex-pkg-dev"
  dns_name    = "pkg.dev."
  description = "Resolve Artifact Registry to private.googleapis.com"
  visibility  = "private"

  cloud_logging_config {
    enable_logging = true
  }

  private_visibility_config {
    networks {
      network_url = google_compute_network.dataplex.self_link
    }
  }
}
