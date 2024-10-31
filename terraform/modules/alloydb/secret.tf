# ----------------------------------------------------------------------------------------------------------------------
# Save Creds
# ----------------------------------------------------------------------------------------------------------------------
resource "google_secret_manager_secret" "alloydb-user" {
  provider = google-beta
  
  secret_id = "alloydb-creds"
  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "alloydb-user" {
  secret = google_secret_manager_secret.alloydb-user.id
  secret_data = "user:${var.user_name},pwd:${random_password.long_passwd.result}"

  depends_on = [
    google_secret_manager_secret.alloydb-user
  ]
}