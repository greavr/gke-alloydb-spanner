# ----------------------------------------------------------------------------------------------------------------------
# Create AlloyDB Cluster
# ----------------------------------------------------------------------------------------------------------------------
module "alloy-db" {
  source               = "GoogleCloudPlatform/alloy-db/google"
  version              = "~> 3.0"

  cluster_id           = "alloydb-cluster"
  cluster_location     = var.region
  project_id           = var.project_id
  cluster_labels       = {}
  cluster_display_name = ""
  cluster_initial_user = {
    user     = var.user_name,
    password = random_password.long_passwd.result
  }
  network_self_link = "projects/${var.project_id}/global/networks/${var.network_name}"

  automated_backup_policy = null

  primary_instance = {
    instance_id       = "primary-instance",
    instance_type     = "PRIMARY",
    machine_cpu_count = 2,
    database_flags    = {},
    display_name      = "alloydb-primary-instance"
  }

  read_pool_instance = null

}

resource "random_password" "long_passwd" {
  length  = 16
  special = true
}