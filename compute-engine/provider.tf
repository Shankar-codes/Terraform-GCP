terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "6.16.0"
    }
  }

  backend "gcs" {
    bucket = "shankar-terraform-state" # bucker name in GCP
    prefix = "state-files" # folder name in the bucket where the store the state files
    #credentials = file("shankar-gcp-practice-90146801ba3f.json")
    }  
}

provider "google" {
  credentials = file("shankar-gcp-practice-90146801ba3f.json")
  project     = "shankar-gcp-practice" # this project id in GCP
  region      = "us-east1"
  zone        = "us-east1-c"
}