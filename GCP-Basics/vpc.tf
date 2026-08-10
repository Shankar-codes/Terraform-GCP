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

# Compute instance creation
resource "google_compute_instance" "web" {
  name         = "devops-web"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-12"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.devops_subnet.id

    access_config {
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash

    apt-get update
    apt-get install -y nginx

    systemctl enable nginx
    systemctl start nginx

    echo "Hello from GCP Terraform" > /var/www/html/index.html
  EOF
}
