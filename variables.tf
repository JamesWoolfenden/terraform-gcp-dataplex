variable "lake_name" {
  type        = string
  description = "Name of the Dataplex lake"

  validation {
    condition     = can(regex("^[a-z][-a-z0-9]{0,62}$", var.lake_name))
    error_message = "var.lake_name must be lowercase and start with a letter"
  }
}

variable "task_id" {
  type        = string
  description = "Identifier of the Dataplex task"

  validation {
    condition     = can(regex("^[a-z][-a-z0-9]{0,62}$", var.task_id))
    error_message = "var.task_id must be lowercase and start with a letter"
  }
}

variable "location" {
  type        = string
  description = "Region of the lake and task"
  default     = "europe-west2"

  validation {
    condition     = length(trimspace(var.location)) > 0
    error_message = "var.location must be a non-empty string"
  }
}

variable "service_account" {
  type        = string
  description = "Email of the service account the task runs as"

  validation {
    condition     = can(regex("^[^@]+@[^@]+$", var.service_account))
    error_message = "var.service_account must be a service account email address"
  }

  validation {
    condition     = !can(regex("-compute@developer\\.gserviceaccount\\.com$", var.service_account))
    error_message = "var.service_account must be a dedicated service account, not the default Compute Engine service account"
  }
}

variable "kms_key_name" {
  type        = string
  description = "Resource name of the Cloud KMS key used to encrypt task execution data (CMEK)"
  sensitive   = true

  validation {
    condition     = length(trimspace(var.kms_key_name)) > 0
    error_message = "var.kms_key_name must be a non-empty string"
  }
}

variable "python_script_file" {
  type        = string
  description = "Cloud Storage URI of the PySpark script the task runs"

  validation {
    condition     = can(regex("^gs://", var.python_script_file))
    error_message = "var.python_script_file must be a gs:// URI"
  }
}

variable "container_image" {
  type        = string
  description = "Container image the Spark driver and executors run"

  validation {
    condition     = length(trimspace(var.container_image)) > 0
    error_message = "var.container_image must be a non-empty string"
  }

  validation {
    condition     = !can(regex(":latest$", var.container_image))
    error_message = "var.container_image must be pinned to a digest or version tag, not :latest"
  }

  validation {
    condition     = can(regex("(@sha256:[a-f0-9]{64}|:[A-Za-z0-9_][A-Za-z0-9_.-]{0,127})$", var.container_image))
    error_message = "var.container_image must end in an explicit version tag or @sha256 digest; an untagged image resolves to :latest"
  }
}

variable "subnetwork" {
  type        = string
  description = "Subnetwork the Spark job runs in"

  validation {
    condition     = length(trimspace(var.subnetwork)) > 0
    error_message = "var.subnetwork must be a non-empty string"
  }
}

variable "schedule" {
  type        = string
  description = "Cron schedule the task runs on, in the form used by Cloud Scheduler, optionally prefixed with CRON_TZ=Region/City or TZ=Region/City"
  default     = "0 3 * * *"

  validation {
    condition     = can(regex("^((CRON_TZ|TZ)=[^ ]+ +)?[^ ]+( +[^ ]+){4}$", trimspace(var.schedule)))
    error_message = "var.schedule must be a five-field cron expression, optionally prefixed with CRON_TZ=Region/City or TZ=Region/City"
  }
}

variable "max_job_execution_lifetime" {
  type        = string
  description = "Maximum time a job may run before it is cancelled, in seconds with an s suffix"
  default     = "7200s"

  validation {
    condition     = can(regex("^[0-9]+s$", var.max_job_execution_lifetime))
    error_message = "var.max_job_execution_lifetime must be a duration in seconds, e.g. 7200s"
  }
}

variable "executors_count" {
  type        = number
  description = "Number of Spark executors"
  default     = 2

  validation {
    condition     = var.executors_count >= 2
    error_message = "var.executors_count must be at least 2"
  }
}

variable "max_executors_count" {
  type        = number
  description = "Maximum number of Spark executors when autoscaling"
  default     = 10

  validation {
    condition     = var.max_executors_count >= 2
    error_message = "var.max_executors_count must be at least 2"
  }
}

variable "description" {
  type        = string
  description = "Description applied to the lake and task"
  default     = "Managed by Terraform"

  validation {
    condition     = length(trimspace(var.description)) > 0
    error_message = "var.description must be a non-empty string"
  }
}

variable "labels" {
  type        = map(string)
  description = "Labels applied to the lake and task"
  default     = {}

  validation {
    condition     = alltrue([for k, v in var.labels : can(regex("^[a-z][a-z0-9_-]{0,62}$", k))])
    error_message = "var.labels keys must be lowercase and start with a letter"
  }
}
