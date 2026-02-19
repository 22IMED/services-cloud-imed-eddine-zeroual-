# # Création du VPC
# resource "google_compute_network" "vpc_network" {
#   name                    = "imed-vpc"
#   auto_create_subnetworks = false
# }

# # Création du Subnet
# resource "google_compute_subnetwork" "subnet" {
#   name          = "imed-subnet"
#   ip_cidr_range = "10.10.0.0/24"
#   region        = var.region
#   network       = google_compute_network.vpc_network.id
# }

# # Règle firewall SSH
# resource "google_compute_firewall" "allow_ssh" {
#   name    = "allow-ssh"
#   network = google_compute_network.vpc_network.name

#   allow {
#     protocol = "tcp"
#     ports    = ["22"]
#   }

#   source_ranges = ["0.0.0.0/0"]
# }

# # Création VM e2-micro
# resource "google_compute_instance" "vm_instance" {
#   name         = "imed-vm"
#   machine_type = "e2-micro"
#   zone         = var.zone

#   boot_disk {
#     initialize_params {
#       image = "debian-cloud/debian-11"
#     }
#   }

#   network_interface {
#   network    = "imed-vpc"
#   subnetwork = "imed-subnet"  
#   access_config {}
# }
# }


# Création du VPC
resource "google_compute_network" "vpc" {
  name                    = "imed-vpc"
  auto_create_subnetworks = false
}

# Création du Subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "imed-subnet"
  ip_cidr_range = "10.10.0.0/24"
  region        = var.region
  network       = google_compute_network.vpc.self_link
}

# Règle firewall SSH
resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc.self_link

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Création VM e2-micro
resource "google_compute_instance" "vm_instance" {
  name         = "imed-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  # On lie la VM au VPC et au Subnet créé
  network_interface {
    network    = google_compute_network.vpc.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link

    # NAT pour accéder à internet
    access_config {}
  }
}