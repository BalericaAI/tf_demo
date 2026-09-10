resource "google_compute_router" "router" {
  name    = "router"
  region  = "us-central1"
  network = google_compute_network.main.id

  bgp {
    asn = 64514
  }

  depends_on = [
    google_compute_network.main
  ]
}

#Router for VPC sidechica


resource "google_compute_router" "router-side" {
  name    = "router-side"
  region  = "us-central1"
  network = google_compute_network.sidechica.id

  bgp {
    asn = 65501
  }

  depends_on = [
    google_compute_network.sidechica
  ]
}