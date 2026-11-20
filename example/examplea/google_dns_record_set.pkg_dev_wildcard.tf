resource "google_dns_record_set" "pkg_dev_wildcard" {
  name         = "*.pkg.dev."
  managed_zone = google_dns_managed_zone.pkg_dev.name
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["private.googleapis.com."]
}
