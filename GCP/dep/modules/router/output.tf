output "router_name" {
  description = "Name of google_compute_router"
  value       = google_compute_router.router.name
}
output "google_compute_router_self_link" {
  description = "The URI of the created resource."
  value       = google_compute_router.router.self_link
}