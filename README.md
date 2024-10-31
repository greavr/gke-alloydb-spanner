# GKE Cluster, with AlloyDB & Spanner

This terraform will deploy the following:
- **VPC Network** - US-Central1, with NAT and IAP, HealthCheck firewall rules
  - **Service Network** - Used to connect AlloyDB to VPC
  - **NAT** box for private access, not currently used
- **AlloyDB** - Cluster in us-central1, with single-node nodepool, 2vCPU 16GB RAM
  - **Credentials** - Stored in Secret Manager
- **SpannerDB** - 2 Node cluster created in us-central1 (2000 PUs)
  - **Databases** - Created one GoogleSQL & one PostgreSQL
- **GKE Cluster** - Standard cluster, public
  - **GKE Node** - E2-Standard8 nodes x3
- **GCS Bucket** - For incidentials
  
## This solution assumes:
- [Project is already created](https://cloud.google.com/resource-manager/docs/creating-managing-projects#console)
- [Billing Account Connected](https://cloud.google.com/billing/docs/how-to/modify-project#enable_billing_for_a_project)
- [Current user has Project Editor Permissions](https://cloud.google.com/iam/docs/grant-role-console#grant_an_iam_role)


# Tool Setup Guide

[Tool Install Guide](tools/ReadMe.md)

# Environment Setup
* Install tools
* Run the following commands to login to gcloud:
```
gcloud auth login
gcloud auth application-default login
gcloud config set project ##ADD_PROJECT_ID_HERE##
```

This will setup your permissions for terraform to run.

# Deploy guide
***Setup.sh*** will create a GCS bucket to store the terraform state in
```
cd terraform
./setup.sh
terraform init
terraform plan
terraform apply
```
