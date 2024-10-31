# ----------------------------------------------------------------------------------------------------------------------
# Main modules
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# Enable APIs
# ----------------------------------------------------------------------------------------------------------------------
resource "google_project_service" "enable-services" {
  for_each = toset(var.services_to_enable)

  project = var.project_id
  service = each.value
  disable_on_destroy = false
}

# ----------------------------------------------------------------------------------------------------------------------
# GCS For template files
# ----------------------------------------------------------------------------------------------------------------------
module "gcs" {
  source = "./modules/gcs"

  project_id = var.project_id
  gcs-bucket-name = var.gcs-bucket-name
  gcs-location = var.regions[0].region


  depends_on = [
    google_project_service.enable-services
  ]
}

# ----------------------------------------------------------------------------------------------------------------------
# Create VPC
# ----------------------------------------------------------------------------------------------------------------------
module "vpc" {
    source = "./modules/vpc"

    project_id = var.project_id
    region = var.regions[0].region
    vpc-name = var.vpc-name
    cidr = var.regions[0].cidr


    depends_on = [
        google_project_service.enable-services,
    ]
}

# ----------------------------------------------------------------------------------------------------------------------
# Create GKE Cluster
# ----------------------------------------------------------------------------------------------------------------------
module "gke" {
    source = "./modules/gke"

    project_id = var.project_id
    region = var.regions[0].region
    vpc-name = var.vpc-name
    gke-nodepool-size = var.gke-nodepool-size
    gke-nodetype = var.gke-nodetype
    sa-roles = var.gke-node-roles
    subnet-name = module.vpc.subnets

    depends_on = [ module.vpc]
}

# ----------------------------------------------------------------------------------------------------------------------
# Create AlloyDB Cluster
# ----------------------------------------------------------------------------------------------------------------------
module "alloydb" {
    source = "./modules/alloydb"

    project_id = var.project_id
    region = var.regions[0].region
    network_name = var.vpc-name


    depends_on = [
        module.vpc,
    ]
}

# ----------------------------------------------------------------------------------------------------------------------
# Create Spanner Cluster
# ----------------------------------------------------------------------------------------------------------------------
module "spanner" {
    source = "./modules/spanner"

    project_id = var.project_id
    region = var.regions[0].region
    network_name = var.vpc-name

    depends_on = [
        module.vpc,
    ]
}