# Represents a Router resource.
resource "google_compute_router" "router" {
  name    = var.name_router
  network = var.network
  bgp {
    asn = var.bgp_asn
  }
}
