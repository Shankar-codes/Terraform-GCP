# provider block to configure the Google Cloud provider
provider "google" {
  credentials = file("shankar-gcp-practice-90146801ba3f.json")
  project     = "shankar-gcp-practice" # this project id in GCP
  region      = "us-east1"
  zone        = "us-east1-c"
}

# this creates the VPC network in GCP
resource "google_compute_network" "vpc_network" {
  name                    = "shankar-vpc-network"
  auto_create_subnetworks = true
}

terraform {
    backend "gcs" {
        bucket = "shankar-terraform-state" # bucker name in GCP
        prefix = "state-files" # folder name in the bucket where the store the state files
        #credentials = file("shankar-gcp-practice-90146801ba3f.json")
    }
}