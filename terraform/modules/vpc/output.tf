output "vpc" {
  value = google_compute_network.demo-vpc.name
}

output "subnets" {
  value = google_compute_subnetwork.subnets.name
}