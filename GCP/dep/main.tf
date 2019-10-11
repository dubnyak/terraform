module "network" {
  source                   = "./modules/network"
  name_network             = "vpc-network"
  auto_create_subnetworks  = "false"
  routing_mode             = "REGIONAL"
  name_subnetwork          = "vpc-subnetwork"
  ip_cidr_range            = "10.2.0.0/16"
  region                   = "us-central1"
  private_ip_google_access = "false"
}

module "router" {
  source      = "./modules/router"
  network     = module.network.self_link
  name_router = "router"
  bgp_asn     = "64514"
}

module "nat" {
  source                             = "./modules/nat"
  router                             = module.router.router_name
  subnetwork                         = module.network.subnet_self_link
  name                               = "nat-1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  source_ip_ranges_to_nat            = ["ALL_IP_RANGES"]
}

module "firewall" {
  source        = "./modules/firewall"
  network       = module.network.self_link
  name_firewall_health_check = "allow-glb-health-check-from-gcp"
  name_firewall_allow_internal = "allow-internal"
}

module "service_account" {
  source        = "./modules/service_account"
  account_id    = "owner-application"
  display_name  = "For application"
  project_roles = [    
    "roles/editor",
    "roles/cloudsql.editor",
    "roles/monitoring.metricWriter",
    "roles/storage.objectViewer", 
    ]
}

module "bucket" {
  source        = "./modules/bucket"
  location      = "EU"
  storage_class = "MULTI_REGIONAL"
}

module "group_instance" {
  source                 = "./modules/group_instance"
  subnetwork             = module.network.subnet_self_link
  service_account_email  = module.service_account.service_account_email
  health_check           = module.lb.health_check
  name_autoscaler        = "my-autoscaler"
  region                 = "us-central1"
  max_replicas           = "5"
  min_replicas           = "1"
  cooldown_period        = "60"
  cpu_utilization_target = "0.8"
  name_instance_group    = "igm-internal"
  base_instance_name     = "internal-glb"
  name_instance_template = "template-backend"
  machine_type           = "n1-standard-1"
  auto_delete            = "true"
  boot                   = "true"
  family                 = "debian-9"
  project                = "debian-cloud"
  startup                = "./modules/group_instance/startup.sh"
  scopes = [
    "https://www.googleapis.com/auth/sqlservice.admin",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring.write",
    "https://www.googleapis.com/auth/trace.append",
    "https://www.googleapis.com/auth/devstorage.read_only"
  ]
  
  cloud_connection_name  = module.sql.cloud_connection_name
  cloud_user       = module.sql.cloud_user
  cloud_password  = module.sql.cloud_password
  cloud_database = module.sql.cloud_database
  cloud_storage = module.bucket.cloud_storage
  token_pass             = "./modules/group_instance/token.txt"
  token                  = "gcp"
  url_git_repo           = "git.epam.com/Kseniia_Dubniak/GCP.git"
  path_to_playbook       = "ansible/playbook.yml"
  project_id             = "gcp-2-253112"
}

module "lb" {
  source          = "./modules/lb"
  group           = module.group_instance.group
  name_forw_rule  = "global-rule"
  port_range      = "80"
  name_http_proxy = "paas-monitor"
  decription      = "target-proxy description"
  name_url_map    = "paas-monitor"
  name_backend             = "backend"
  port_name                = "paas-monitor"
  protocol                 = "HTTP"
  timeout_sec_backend      = "10"
  balancing_mode           = "RATE"
  capacity_scaler          = "0.4"
  max_rate_per_instance    = "50"
  name_health_check        = "check-backend"
  check_interval_sec       = "10"
  timeout_sec_health_check = "5"
  healthy_threshold        = "2"
  unhealthy_threshold      = "5"
}

module "sql" {
  source                  = "./modules/sql"
  network                 = module.network.self_link
  name_database           = "my-database"
  name_private_ip_address = "private-ip-address"
  purpose                 = "VPC_PEERING"
  address_type            = "INTERNAL"
  prefix_length           = "16"
  region                  = "us-central1"
  tier                    = "db-f1-micro"
  ipv4_enabled            = "false"
  name_user               = "root"
}
