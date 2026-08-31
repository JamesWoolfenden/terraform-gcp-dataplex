output "lake_id" {
  value       = google_dataplex_lake.main.id
  description = "ID of the Dataplex lake"
}

output "task_id" {
  value       = google_dataplex_task.main.id
  description = "ID of the Dataplex task"
}
