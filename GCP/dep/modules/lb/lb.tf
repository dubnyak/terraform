resource "google_compute_global_address" "external" {
   name = "lb01"
   address_type = "EXTERNAL"
 }
# Global forwarding rules are used to forward traffic to the correct load balancer for HTTP load balancing.
resource "google_compute_global_forwarding_rule" "default" {
  provider   = google-beta
  name       = var.name_forw_rule
  target     = google_compute_target_http_proxy.default.self_link
  port_range = var.port_range
  ip_address = google_compute_global_address.external.address 
}

# Represents a TargetHttpProxy resource, which is used by one or more global forwarding rule to route incoming HTTP requests to a URL map.
resource "google_compute_target_http_proxy" "default" {
  provider    = google-beta
  name        = var.name_http_proxy
  description = var.decription
  url_map     = google_compute_url_map.default.self_link
}
# A Backend Service defines a group of virtual machines that will serve traffic for load balancing. 
resource "google_compute_backend_service" "default" {
  provider    = google-beta
  name        = var.name_backend
  port_name   = var.port_name
  protocol    = var.protocol
  timeout_sec = var.timeout_sec_backend

  backend {
    group                 = var.group
    balancing_mode        = var.balancing_mode
    capacity_scaler       = var.capacity_scaler
    max_rate_per_instance = var.max_rate_per_instance
  }

  health_checks = [google_compute_health_check.default.self_link]
}

# UrlMaps are used to route requests to a backend service based on rules that you define for the host and path of an incoming URL.
resource "google_compute_url_map" "default" {
  provider        = google-beta
  name            = var.name_url_map
  default_service = google_compute_backend_service.default.self_link
}

# Health Checks determine whether instances are responsive and able to do work.
resource "google_compute_health_check" "default" {
  provider           = google-beta
  name               = var.name_health_check
  check_interval_sec = var.check_interval_sec
  timeout_sec        = var.timeout_sec_health_check
  healthy_threshold   = var.healthy_threshold 
  unhealthy_threshold = var.unhealthy_threshold

  lifecycle {
    create_before_destroy = true
  }
  http_health_check {
     port = 8080
  }  
}
