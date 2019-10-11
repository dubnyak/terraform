# Manages a VPC network or legacy network resource 
resource "google_compute_network" "vpc_network" {
  name                    = var.name_network
  auto_create_subnetworks = var.auto_create_subnetworks
  routing_mode            = var.routing_mode
}

# Manages a VPC subnetwork 
resource "google_compute_subnetwork" "vpc_subnetwork" {

  name          = var.name_subnetwork
  ip_cidr_range = var.ip_cidr_range
  region        = var.region
  network       = google_compute_network.vpc_network.self_link

  private_ip_google_access = var.private_ip_google_access
}