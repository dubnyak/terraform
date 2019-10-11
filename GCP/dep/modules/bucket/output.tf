output "cloud_storage" {
  description = "Name of google storage bucket"
  value       = google_storage_bucket.storage_bucket.name
}
