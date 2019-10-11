# Represents a SQL database inside the Cloud SQL instance
resource "google_sql_database" "database" {
  name     = var.name_database
  instance = google_sql_database_instance.instance.name
}

# Represents a Global Address resource. 
resource "google_compute_global_address" "private_ip_address" {
  provider = "google-beta"

  name          = var.name_private_ip_address
  purpose       = var.purpose
  address_type  = var.address_type
  prefix_length = var.prefix_length
  network       = var.network
}

resource "google_service_networking_connection" "private_vpc_connection" {
  provider = "google-beta"

  network                 = var.network
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

# Random for name database instance
resource "random_id" "db_name_suffix" {
  byte_length = 4
}

# Creates a new Google SQL Database Instance.
resource "google_sql_database_instance" "instance" {
  provider = google-beta

  name   = "private-instance-${random_id.db_name_suffix.hex}"
  region = var.region

  depends_on = [
    "google_service_networking_connection.private_vpc_connection"
  ]

  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = var.network
    }
  }
}
# Random for user password
resource "random_id" "user-password" {
  byte_length = 8
}

# Creates a new Google SQL User on a Google SQL User Instance.
resource "google_sql_user" "users" {
  name     = var.name_user
  instance = google_sql_database_instance.instance.name
  password = random_id.user-password.hex
}
