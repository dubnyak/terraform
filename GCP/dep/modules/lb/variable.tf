# ------------google_compute_global_forwarding_rule-----------------------
variable "name_forw_rule" {
  description = "Name of the resource."
}
variable "port_range" {
  description = "This field is used along with the target field for TargetHttpProxy, TargetHttpsProxy, TargetSslProxy, TargetTcpProxy, TargetVpnGateway, TargetPool, TargetInstance. "
}

# --------------------google_compute_target_http_proxy--------------------
variable "name_http_proxy" {
  description = "Name of the resource."
}
variable "decription" {
  description = "An optional description of this resource."
}

# -------------------google_compute_url_map-------------------------------
variable "name_url_map" {
  description = "Name of the resource."
}
#variable "name_path_matcher" {
 # description = "The name to which this PathMatcher is referred by the HostRule."
#}
# ----------------------google_compute_backend_service------------------------

variable "name_backend" {
  description = "Name of the resource. "
}
variable "port_name" {
  description = "Name of backend port."
}
variable "protocol" {
  description = "The protocol this BackendService uses to communicate with backends."
}
variable "timeout_sec_backend" {
  description = "How many seconds to wait for the backend before considering it a failed request."
}
variable "group" {
  description = "The fully-qualified URL of an Instance Group or Network Endpoint Group resource."
}
variable "balancing_mode" {
  description = "Specifies the balancing mode for this backend."
}
variable "capacity_scaler" {
  description = "A multiplier applied to the group's maximum servicing capacity (based on UTILIZATION, RATE or CONNECTION). "
}
variable "max_rate_per_instance" {
  description = "he max requests per second that a single backend instance can handle. This is used to calculate the capacity of the group."
}

# ---------------------------------------google_compute_health_check----------------------------
variable "name_health_check" {
  description = "Name of the resource."
}
variable "check_interval_sec" {
  description = "How often (in seconds) to send a health check."
}
variable "timeout_sec_health_check" {
  description = "How long (in seconds) to wait before claiming failure."
}
variable "healthy_threshold" {
  description = "A so-far unhealthy instance will be marked healthy after this many consecutive successes. "
}
variable "unhealthy_threshold" {
  description = "A so-far healthy instance will be marked unhealthy after this many consecutive failures.  "
}
