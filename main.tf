provider "google" {
  version = "~> 3.67.0"
  project = var.project
  region  = var.region
  credentials = file("credentials.json")
}

# Create build and run
resource "null_resource" "gcloud" {
  provisioner "local-exec" {
    command = "gcloud builds submit --config=cloudbuild.yaml"
  }
}

resource "google_container_cluster" "gke-cluster" {
  name                = "my-first-gke-cluster"
  network             = "default"
  zone                = "us-central1-a"
  initial_node_count  = 2
}

# Create build and run
resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "kubectl apply -f deploy.yaml"
  }
}
