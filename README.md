# terraform-gcp-dataplex

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-dataplex/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-dataplex)
[![Latest Release](https://img.shields.io/github/release/terraform-gcp-dataplex.svg)](https://github.com/JamesWoolfenden/terraform-gcp-dataplex/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-dataplex.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-dataplex/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.5.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)

Terraform module for a Dataplex lake and a recurring CMEK-encrypted PySpark
task on it. Exercises holden's `google_dataplex_task` policies.

## Usage

Add **module.dataplex.tf** to your code:-

```terraform
module "dataplex" {
  source             = "jameswoolfenden/dataplex/gcp"
  version            = "0.0.1"
  lake_name          = "example-lake"
  task_id            = "example-task"
  location           = "europe-west2"
  service_account    = google_service_account.dataplex.email
  kms_key_name       = google_kms_crypto_key.dataplex.id
  python_script_file = "gs://example-dataplex-scripts/jobs/example.py"
  container_image    = "europe-docker.pkg.dev/example/images/spark:3.5.1"
  subnetwork         = google_compute_subnetwork.dataplex.id
}
```

`var.container_image` rejects `:latest` — a Spark job that silently changes
runtime between runs is not reproducible. The task runs as
`var.service_account`, which needs `roles/dataproc.worker` plus read access to
the script bucket and whatever the job touches.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_dataplex_lake.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataplex_lake) | resource |
| [google_dataplex_task.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dataplex_task) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_container_image"></a> [container\_image](#input\_container\_image) | Container image the Spark driver and executors run | `string` | n/a | yes |
| <a name="input_description"></a> [description](#input\_description) | Description applied to the lake and task | `string` | `"Managed by Terraform"` | no |
| <a name="input_executors_count"></a> [executors\_count](#input\_executors\_count) | Number of Spark executors | `number` | `2` | no |
| <a name="input_kms_key_name"></a> [kms\_key\_name](#input\_kms\_key\_name) | Resource name of the Cloud KMS key used to encrypt task execution data (CMEK) | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels applied to the lake and task | `map(string)` | `{}` | no |
| <a name="input_lake_name"></a> [lake\_name](#input\_lake\_name) | Name of the Dataplex lake | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Region of the lake and task | `string` | `"europe-west2"` | no |
| <a name="input_max_executors_count"></a> [max\_executors\_count](#input\_max\_executors\_count) | Maximum number of Spark executors when autoscaling | `number` | `10` | no |
| <a name="input_max_job_execution_lifetime"></a> [max\_job\_execution\_lifetime](#input\_max\_job\_execution\_lifetime) | Maximum time a job may run before it is cancelled, in seconds with an s suffix | `string` | `"7200s"` | no |
| <a name="input_python_script_file"></a> [python\_script\_file](#input\_python\_script\_file) | Cloud Storage URI of the PySpark script the task runs | `string` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Cron schedule the task runs on, in the form used by Cloud Scheduler | `string` | `"0 3 * * *"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Email of the service account the task runs as | `string` | n/a | yes |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | Subnetwork the Spark job runs in | `string` | n/a | yes |
| <a name="input_task_id"></a> [task\_id](#input\_task\_id) | Identifier of the Dataplex task | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_lake_id"></a> [lake\_id](#output\_lake\_id) | ID of the Dataplex lake |
| <a name="output_task_id"></a> [task\_id](#output\_task\_id) | ID of the Dataplex task |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Help

**Got a question?**

File a GitHub [issue](https://github.com/JamesWoolfenden/terraform-gcp-dataplex/issues).

## Copyrights

Copyright © 2019-2026 [Jim Woolfenden](https://github.com/JamesWoolfenden)

## License

See [LICENSE](LICENSE) for full details.


<!-- BEGINNING OF PRE-COMMIT-PIKE DOCS HOOK -->
The Terraform resource required is:

```golang
# apply role
resource "google_project_iam_custom_role" "terraform_pike" {
  project     = "pike-477416"
  role_id     = "terraform_pike"
  title       = "terraform_pike"
  description = "A user with least privileges"
  permissions = [
    "dataplex.lakes.create",
    "dataplex.lakes.delete",
    "dataplex.lakes.get",
    "dataplex.lakes.update",
    "dataplex.tasks.create",
    "dataplex.tasks.delete",
    "dataplex.tasks.get",
    "dataplex.tasks.update"
  ]
}

# plan role
resource "google_project_iam_custom_role" "terraform_pike_plan" {
  project     = "pike-477416"
  role_id     = "terraform_pike_plan"
  title       = "terraform_pike_plan"
  description = "A user with least privileges"
  permissions = [
    "dataplex.lakes.get",
    "dataplex.tasks.get"
  ]
}


```
<!-- END OF PRE-COMMIT-PIKE DOCS HOOK -->