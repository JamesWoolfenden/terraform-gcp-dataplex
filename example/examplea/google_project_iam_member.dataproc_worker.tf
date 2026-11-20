# Dataplex Spark tasks run on Dataproc Serverless, which requires the task's
# execution service account to hold roles/dataproc.worker.
data "google_client_config" "current" {}

resource "google_project_iam_member" "dataproc_worker" {
  project = data.google_client_config.current.project
  role    = "roles/dataproc.worker"
  member  = "serviceAccount:${google_service_account.dataplex.email}"
}
