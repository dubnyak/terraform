variable "name_router" {
  description = "Name of the resource."
}
variable "bgp_asn" {
  description = "Local BGP Autonomous System Number (ASN). Must be an RFC6996 private ASN, either 16-bit or 32-bit. "
}
variable "network" {
  description = "A reference to the network to which this router belongs."
}