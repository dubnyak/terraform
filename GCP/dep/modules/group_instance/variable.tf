# --------------google_compute_autoscaler-------------------

variable "name_autoscaler" {
  description = "Name of the resource."
}
variable "region" {
  description = "URL of the region where the instance group resides."
}
variable "max_replicas" {
  description = "The maximum number of instances that the autoscaler can scale up to."
}
variable "min_replicas" {
  description = "The minimum number of replicas that the autoscaler can scale down to."
}
variable "cooldown_period" {
  description = "The number of seconds that the autoscaler should wait before it starts collecting information from a new instance."
}
variable "cpu_utilization_target" {
  description = "Defines the CPU utilization policy that allows the autoscaler to scale based on the average CPU utilization of a managed instance group."
}

# ---------------------google_compute_instance_group_manager--------------------------------

variable "name_instance_group" {
  description = "The name of the instance group manager."
}
variable "base_instance_name" {
  description = "The base instance name to use for instances in this group."
}
variable "health_check" {
  description = "The health check resource that signals autohealing."
}

# ------------------google_compute_instance_template--------------------------------------

variable "name_instance_template" {
  description = "The name of the instance template."
}
variable "machine_type" {
  description = "The machine type to create."
}
variable "subnetwork" {
  description = "The name of the subnetwork to attach this interface to."
}
variable "service_account_email" {
  description = "Service account to attach to the instance."
}
variable "auto_delete" {
  description = "Whether or not the disk should be auto-deleted. This defaults to true."
}
variable "boot" {
  description = "Indicates that this is a boot disk."
}
variable "family" {
  description = "The name of the image family to which this image belongs."
}
variable "project" {
  description = "The ID of the project in which the resource belongs."
}
variable "startup" {
  description = "The path to startup script"
}
variable "scopes" {
  description = "A list of service scopes."
}

# -------------------------------- VARS for template_file---------------------------
variable "token_pass" {
  description = "Path to file with github token."
}
variable "token" {
  description = "Name your github token."
}
variable "url_git_repo" {
  description = "like this: git.epam.com/name_folder/GCP.git"
}
variable "path_to_playbook" {
  description = "Path to ansible playbook"
}
variable "cloud_connection_name" {
  description = "Path to ansible playbook"
}
variable "cloud_user" {
  description = "Path to ansible playbook"
}
variable "cloud_password" {
  description = "Path to ansible playbook"
}
variable "cloud_database" {
  description = "Path to ansible playbook"
}
variable "cloud_storage" {
  description = "Path to ansible playbook"
}
variable "project_id" {
  description = "ID your project"
}