# Manages a Cloud NAT
resource "google_compute_router_nat" "simple-nat" {
  name                               = var.name
  router                             = var.router
  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
  subnetwork {
    name                    = var.subnetwork
    source_ip_ranges_to_nat = var.source_ip_ranges_to_nat
  }
}


