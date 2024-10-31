# ----------------------------------------------------------------------------------------------------------------------
# Change Below 
# ----------------------------------------------------------------------------------------------------------------------
variable "project_id" {
  type        = string
  description = "project id required"
}
variable "project_name" {
  type        = string
  description = "project name in which demo deploy"
  default = ""
}

# Service to enable
variable "services_to_enable" {
    description = "List of GCP Services to enable"
    type    = list(string)
    default =  [
        "compute.googleapis.com",
        "iap.googleapis.com",
        "secretmanager.googleapis.com",
        "cloudbuild.googleapis.com",
        "cloudresourcemanager.googleapis.com",
        "container.googleapis.com",
        "gkeconnect.googleapis.com",
        "gkehub.googleapis.com",
        "iam.googleapis.com",
        "logging.googleapis.com",
        "monitoring.googleapis.com",
        "opsconfigmonitoring.googleapis.com",
        "serviceusage.googleapis.com",
        "stackdriver.googleapis.com",
        "servicemanagement.googleapis.com",
        "servicecontrol.googleapis.com",
        "storage.googleapis.com",
        "run.googleapis.com",
        "sourcerepo.googleapis.com",
        "secretmanager.googleapis.com",
        "alloydb.googleapis.com",
        "spanner.googleapis.com",
        "servicenetworking.googleapis.com"   
      ]
}


# List of regions (support for multi-region deployment)
variable "regions" { 
    type = list(object({
        region = string
        cidr = string
        zone = string
        })
    )
    default = [{
            region = "us-central1"
            cidr = "10.0.0.0/24"
            zone = "us-central1-a"
        }]
}

## GKE Configure
# Worker Node Count
variable "gke-nodepool-size" {
    description = "# of Kubernetes worker nodes"
    type = number
    default = 1
}

# Instance Type
variable "gke-nodetype" {
  description = "GKE Nodespec"
  type = string
  default = "e2-standard-8"
}

# GKE-Node Roles
variable "gke-node-roles" {
  default = [
      "logging.logWriter",
      "monitoring.metricWriter",
      "stackdriver.resourceMetadata.writer",
      "opsconfigmonitoring.resourceMetadata.writer",
      "secretmanager.secretAccessor"
  ]
}

# Storage Bucket
variable "gcs-bucket-name" {
    default = "sample-bucket"
    description = "Sample Bucket"
    type = string
    }

# VPC Name
variable "vpc-name" {
  type = string
  default = "sample-vpc"
}