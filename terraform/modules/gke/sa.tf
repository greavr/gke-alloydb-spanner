# ----------------------------------------------------------------------------------------------------------------------
# GKE SA
# ----------------------------------------------------------------------------------------------------------------------
resource "google_service_account" "gke-node-sa" {
    account_id   = "gke-node-sa"
    display_name = "gke-node-sa"
}

resource "google_project_iam_member" "gke-node-sa-roles" {
    project = var.project_id
    for_each = toset(var.sa-roles)
    role    = "roles/${each.value}"
    member  = "serviceAccount:${google_service_account.gke-node-sa.email}"
    depends_on = [ google_service_account.gke-node-sa ]
}