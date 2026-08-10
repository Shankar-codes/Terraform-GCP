# VPC creation
resource "google_compute_network" "devops_vpc" {
  project                 = var.project_id
  name                    = "devops_vpc"
  auto_create_subnetworks = false
}

# Subnetwork creation
resource "google_compute_subnetwork" "devops_subnet" {
  project                  = var.project_id
  name                     = "devops_subnet"
  ip_cidr_range            = "10.0.1.0/24"
  region                   = var.region
  network                  = google_compute_network.devops_vpc.id
}

# Firewall rule creation
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.devops_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# HTTP firewall for nginx
resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.devops_vpc.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}
