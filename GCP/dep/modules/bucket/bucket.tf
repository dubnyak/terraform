# Generate randomness for bucket name
resource "random_id" "bucket" {
  byte_length = 8
}

resource "google_storage_bucket" "storage_bucket" {
  name          = "bucket-${random_id.bucket.hex}"
  location      = var.location
  storage_class = var.storage_class
}