# ----------------------------------------------------------------------------------------------------------------------
# Create Spanner Cluster
# ----------------------------------------------------------------------------------------------------------------------
resource "google_spanner_instance" "example" {
  config       = "regional-${var.region}"
  display_name = "Sample Spanner"
  num_nodes    = 2
  edition      = "STANDARD"
  labels = {
    "env" = "demo"
  }
}

resource "google_spanner_database" "database" {
  instance = google_spanner_instance.example.name
  name     = var.database_name
}

resource "google_spanner_database" "database-postgres" {
  instance = google_spanner_instance.example.name
  database_dialect = "POSTGRESQL"
  name     = "${var.database_name}-postgres"
}