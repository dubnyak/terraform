# -------------------------google_service_account----------------------

variable "account_id" {
  description = "The account id that is used to generate the service account email address and a stable unique id."
}
variable "display_name" {
  description = "The display name for the service account. Can be updated without creating a new resource."
}

# --------------------------google_service_account_iam_policy--------------

variable "project_roles" {
  description = "Common roles to apply to all service accounts, project=>role as elements. in [ ]"
}
