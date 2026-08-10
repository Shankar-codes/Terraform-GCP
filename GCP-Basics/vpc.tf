resource "google_compute_network" "devops_vpc" {
  project                 = var.project_id
  name                    = "devops_vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "devops_subnet" {
  project                  = var.project_id
  name                     = "devops_subnet"
  ip_cidr_range            = "10.0.1.0/24"
  region                   = var.region
  network                  = google_compute_network.devops_vpc.id
}