variable "name" {
  description = "A unique name for Cloud NAT, required by GCE."
}
variable "router" {
  description = "The name of the router in which this NAT will be configured."
}
variable "nat_ip_allocate_option" {
  description = "How external IPs should be allocated for this NAT. Valid values are AUTO_ONLY or MANUAL_ONLY."
}
variable "source_subnetwork_ip_ranges_to_nat" {
  description = "How NAT should be configured per Subnetwork.Valid values include: ALL_SUBNETWORKS_ALL_IP_RANGES, ALL_SUBNETWORKS_ALL_PRIMARY_IP_RANGES, LIST_OF_SUBNETWORKS."
}
variable "subnetwork" {
  description = "The self_link of the subnetwork to NAT."
}
variable "source_ip_ranges_to_nat" {
  description = " List of options for which source IPs in the subnetwork should have NAT enabled. Supported values include: ALL_IP_RANGES, LIST_OF_SECONDARY_IP_RANGES, PRIMARY_IP_RANGE"
}
