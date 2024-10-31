# ----------------------------------------------------------------------------------------------------------------------
# CREATE VPC & Subnets
# ----------------------------------------------------------------------------------------------------------------------
resource "google_compute_network" "demo-vpc" {
  name = var.vpc-name            
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnets" {
  name = "${var.region}"
  ip_cidr_range =  "${var.cidr}"       
  region        = "${var.region}"
  network       = var.vpc-name

  depends_on = [ google_compute_network.demo-vpc ]
}

resource "google_compute_router" "nat_router" {
  name    = "${var.vpc-name}-nat-router"
  network = google_compute_network.demo-vpc.id
  region  = var.region

  bgp {
    asn = 64514
  }

  depends_on = [ google_compute_network.demo-vpc ]
}

resource "google_compute_router_nat" "nat_gateway" {
  name                               = "${var.vpc-name}-nat-gw"
  router                             = google_compute_router.nat_router.name
  region                             = google_compute_router.nat_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }

  depends_on = [ google_compute_router.nat_router ]
}

# Create an IP address
resource "google_compute_global_address" "private_ip_alloc" {
  name          = "private-ip-alloc"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = google_compute_network.demo-vpc.id

  depends_on = [ google_compute_network.demo-vpc ]
}

# Create a private connection
resource "google_service_networking_connection" "default" {
  network                 = google_compute_network.demo-vpc.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_alloc.name]

  depends_on = [ google_compute_global_address.private_ip_alloc ]
}