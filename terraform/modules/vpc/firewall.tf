# IAP Firewall Rule
# ----------------------------------------------------------------------------------------------------------------------
resource "google_compute_firewall" "iap" {
    name    = "allow-iap-ssh-${google_compute_network.demo-vpc.name}"
    network = google_compute_network.demo-vpc.name


    allow {
        protocol = "tcp"
        ports    = ["22"]
    }

    source_ranges = ["35.235.240.0/20"]

    depends_on = [
        google_compute_network.demo-vpc
        ]
}

resource "google_compute_firewall" "health-checks" {
    name    = "allow-healthchecks-${google_compute_network.demo-vpc.name}"
    network = google_compute_network.demo-vpc.name


    allow {
        protocol = "tcp"
        ports    = []
    }

    source_ranges = ["35.191.0.0/16","130.211.0.0/22"]

    depends_on = [
        google_compute_network.demo-vpc
        ]
}

