# Autoscalers allow you to automatically scale virtual machine instances in managed instance groups
# according to an autoscaling policy that you define.
resource "google_compute_region_autoscaler" "default" {
  provider = google-beta
  name     = var.name_autoscaler
  region   = var.region
  target   = google_compute_region_instance_group_manager.igm.self_link

  autoscaling_policy {
    max_replicas    = var.max_replicas
    min_replicas    = var.min_replicas
    cooldown_period = var.cooldown_period

    cpu_utilization {
      target = var.cpu_utilization_target
    }
  }
}

# The Google Compute Engine Instance Group Manager API creates and manages pools of homogeneous 
# Compute Engine virtual machine instances from a common instance template.
resource "google_compute_region_instance_group_manager" "igm" {
  provider = "google-beta"
  name     = var.name_instance_group
  version {
    instance_template = google_compute_instance_template.instance_template.self_link
    name              = "primary"
  }
    named_port {
    name = "paas-monitor"
    port = 8080
  }
  base_instance_name = var.base_instance_name
  region               = var.region

  auto_healing_policies {
    health_check      = var.health_check
    initial_delay_sec = 30
  }
}

# Manages a VM instance template resource within GCE. 
resource "google_compute_instance_template" "instance_template" {
  provider     = google-beta
  name         = var.name_instance_template
  machine_type = var.machine_type
  network_interface {
    subnetwork = var.subnetwork
    access_config {
      // Ephemeral IP
    }
  }
  tags = ["paas-monitor"]

  metadata_startup_script = data.template_file.startup.rendered

  service_account {
    email  = var.service_account_email
    scopes = concat( var.scopes )
  }
  disk {
    source_image = data.google_compute_image.debian_image.self_link
    auto_delete  = var.auto_delete
    boot         = var.boot
  }
}

# Represents an Image resource.
data "google_compute_image" "debian_image" {
  provider = google-beta
  family   = var.family
  project  = var.project
}

# The template_file data source renders a template from a template string.
data "template_file" "startup" {
  template = "${file(var.startup)}"

  vars = {
    token_pass            = "${file(var.token_pass)}"
    token                 = var.token
    url_git_repo          = var.url_git_repo
    path_to_playbook      = var.path_to_playbook
    cloud_connection_name = var.cloud_connection_name
    cloud_user            = var.cloud_user
    cloud_password        = var.cloud_password
    cloud_database        = var.cloud_database
    cloud_storage         = var.cloud_storage
    project_id            = var.project_id
  }
}
