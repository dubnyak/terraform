terraform {
  backend "gcs" {
    bucket = "ere"
    prefix = "terraform"
  }
}