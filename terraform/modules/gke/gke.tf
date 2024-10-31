# ----------------------------------------------------------------------------------------------------------------------
# GKE Cluster
# ----------------------------------------------------------------------------------------------------------------------
# GKE cluster
data "google_container_engine_versions" "gke_version" {
  location = var.region
  version_prefix = "1.27."
}

resource "google_container_cluster" "primary" {
    name     = "${var.project_id}-gke"
    location = var.region

    # We can't create a cluster with no node pool defined, but we want to only use
    # separately managed node pools. So we create the smallest possible default
    # node pool and immediately delete it.
    initial_node_count       = var.gke-nodepool-size

    network    = var.vpc-name
    subnetwork = var.subnet-name

    enable_shielded_nodes = true
    deletion_protection = false


    # required to enable workload identity
    workload_identity_config {
        workload_pool = "${var.project_id}.svc.id.goog"
    }

    node_config {
        service_account = google_service_account.gke-node-sa.email
        oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

        labels = {
            env = var.project_id
        }

        machine_type = var.gke-nodetype

        tags = ["gke-node", "${var.project_id}-gke"]

        metadata = {
            disable-legacy-endpoints = "true"
        }

        shielded_instance_config {  
            enable_secure_boot         = true
            enable_integrity_monitoring = true
        }

        # required to enable workload identity on node pool
        workload_metadata_config {
            mode = "GKE_METADATA"
        }

        gcfs_config {
            enabled = true
        }
    }
    
    depends_on = [ google_service_account.gke-node-sa ]
}