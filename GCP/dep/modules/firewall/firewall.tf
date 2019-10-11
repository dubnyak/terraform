resource "google_compute_firewall" "health-check" {
  ## firewall rules enabling the load balancer health checks
  name    = var.name_firewall_health_check
  network = var.network

  description = "allow Google health checks and network load balancers access"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["8080", "80"]
  }

  source_ranges = ["35.191.0.0/16", "130.211.0.0/22", "209.85.152.0/22", "209.85.204.0/22"]
  target_tags   = ["paas-monitor"]
}

resource "google_compute_firewall" "allow-internal" {
  name    = var.name_firewall_allow_internal
  network = var.network

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }
  
  target_tags   = ["paas-monitor"]
}
