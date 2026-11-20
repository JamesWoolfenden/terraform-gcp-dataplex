# The default route is deleted, so the public googleapis.com addresses are
# unreachable. This private zone resolves Google APIs to the
# private.googleapis.com VIP that google_compute_route.private_google_apis routes.
resource "google_dns_managed_zone" "googleapis" {
  name        = "dataplex-googleapis"
  dns_name    = "googleapis.com."
  description = "Resolve Google APIs to private.googleapis.com"
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
