resource "google_dataplex_task" "main" {
  task_id     = var.task_id
  location    = var.location
  lake        = google_dataplex_lake.main.name
  description = var.description

  trigger_spec {
    type     = "RECURRING"
    schedule = var.schedule
  }

  execution_spec {
    service_account            = var.service_account
    kms_key                    = var.kms_key_name
    max_job_execution_lifetime = var.max_job_execution_lifetime
  }

  spark {
    python_script_file = var.python_script_file

    infrastructure_spec {
      batch {
        executors_count     = var.executors_count
        max_executors_count = var.max_executors_count
      }

      container_image {
        image = var.container_image
      }

      vpc_network {
        sub_network = var.subnetwork
      }
    }
  }

  labels = var.labels

  lifecycle {
    precondition {
      condition     = var.max_executors_count >= var.executors_count
      error_message = "var.max_executors_count must be greater than or equal to var.executors_count"
    }
  }
}
