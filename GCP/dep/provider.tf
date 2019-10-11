provider "google" {
  credentials = "${file("account.json")}"
  project     = var.project
  region      = var.region
}
provider "google-beta" {
  credentials = "${file("account.json")}"
  project     = var.project
  region      = var.region
}
