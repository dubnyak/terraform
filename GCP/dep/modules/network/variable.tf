# ----------------------Manages a VPC network or legacy network resource -----------------------

variable "name_network" {
  description = "Name of the resource."
}
variable "auto_create_subnetworks" {
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
}
variable "routing_mode" {
  description = "Sets the network-wide routing mode for Cloud Routers to use. Accepted values are 'GLOBAL' or 'REGIONAL'. Defaults to 'REGIONAL'. Refer to the Cloud Router documentation for more details."
}

# ---------------------------google_compute_subnetwork----------------------------

variable "name_subnetwork" {
  description = "Name of the resource."
}
variable "ip_cidr_range" {
  description = "The range of internal addresses that are owned by this subnetwork. Provide this property when you create the subnetwork. For example, 10.0.0.0/8 or 192.168.0.0/16. Ranges must be unique and non-overlapping within a network. Only IPv4 is supported."
}
variable "region" {
  description = "URL of the GCP region for this subnetwork."
}

variable "private_ip_google_access" {
  description = "Whether the VMs in this subnet can access Google services without assigned external IP addresses."
}
