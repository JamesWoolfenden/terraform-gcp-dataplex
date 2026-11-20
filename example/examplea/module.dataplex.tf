# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
# holden:ignore:HLD_TF_065: for expansion
module "dataplex" {
  source             = "../../"
  lake_name          = "example-lake"
  task_id            = "example-task"
  location           = "europe-west2"
  service_account    = google_service_account.dataplex.email
  kms_key_name       = google_kms_crypto_key.dataplex.id
  python_script_file = "gs://${google_storage_bucket.scripts.name}/jobs/example.py"
  container_image    = "europe-docker.pkg.dev/example/images/spark:3.5.1"
  subnetwork         = google_compute_subnetwork.dataplex.id

  depends_on = [
    google_kms_crypto_key_iam_member.dataplex_service_agent,
    google_kms_crypto_key_iam_member.dataproc_service_agent,
    google_kms_crypto_key_iam_member.compute_service_agent,
    google_kms_crypto_key_iam_member.gcs_service_agent,
    google_project_iam_member.dataproc_worker,
    google_storage_bucket_iam_member.scripts_reader,
    google_dns_record_set.googleapis_wildcard,
    google_dns_record_set.pkg_dev_wildcard,
  ]
}
