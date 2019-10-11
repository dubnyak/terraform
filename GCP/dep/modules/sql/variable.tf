# -----------------google_sql_database-------------------------------

variable "name_database" {
  description = "The name of the database in the Cloud SQL instance."
}

# ------------------google_compute_global_address--------------------

variable "name_private_ip_address" {
  description = "Name of the resource. "
}
variable "purpose" {
  description = "The purpose of the resource."
}
variable "address_type" {
  description = "The type of the address to reserve.EXTERNAL or INTERNAL"
}
variable "prefix_length" {
  description = "The prefix length of the IP range."
}
variable "network" {
  description = "The URL of the network in which to reserve the IP range."
}

# -------------------------google_sql_database_instance---------------------

variable "region" {
  description = "The region the instance will sit in."
}
variable "tier" {
  description = "The machine tier (First Generation) or type (Second Generation) to use."
}
variable "ipv4_enabled" {
  description = "Whether this Cloud SQL instance should be assigned a public IPV4 address."
}

# ------------------------google_sql_user-----------------------------------

variable "name_user" {
  description = "The name of the user."
}