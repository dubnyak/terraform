output "cloud_database" {
  description = "Name of sql database instance for MYSQL"
  value       = google_sql_database_instance.instance.name
}

output "cloud_connection_name" {
  description = "connection_name of sql database instance for MYSQL"
  value       = google_sql_database_instance.instance.connection_name
}

output "cloud_user" {
  description = "connection_name of sql database instance for MYSQL"
  value       = google_sql_user.users.name
}

output "cloud_password" {
  description = "The auto generated default user password if no input password was provided"
  value       = random_id.user-password.hex
}