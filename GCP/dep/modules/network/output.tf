output "self_link" {
  value = google_compute_network.vpc_network.self_link
}
output "subnet_self_link" {
  value = google_compute_subnetwork.vpc_subnetwork.self_link
}
output "source_ranges" {
  value = google_compute_subnetwork.vpc_subnetwork.ip_cidr_range
}