resource "google_compute_network" "devops_vpc" {
  project                 = var.project_id
  name                    = "devops_vpc"
  auto_create_subnetworks = false
}