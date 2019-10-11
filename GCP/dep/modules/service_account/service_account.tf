# Allows management of a Google Cloud Platform service account
resource "google_service_account" "application" {
  account_id   = var.account_id
  display_name = var.display_name
}
# IAM policy for service account
resource "google_project_iam_member" "iam_member" {
  count  = "${length(var.project_roles)}"
  role   = "${element(var.project_roles , count.index)}"
  member = "serviceAccount:${google_service_account.application.email}"

  depends_on = ["google_service_account.application"]
}

