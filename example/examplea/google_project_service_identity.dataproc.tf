# Dataplex Spark tasks run as Dataproc Serverless batches. The Dataproc service
# agent is otherwise created lazily on first use, so it is created explicitly
# here to make the CMEK grant below safe on a fresh project.
resource "google_project_service_identity" "dataproc" {
  provider = google-beta
  service  = "dataproc.googleapis.com"
}
