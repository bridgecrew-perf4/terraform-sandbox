provider "google" {
  project     = "kaggle-261706"
  credentials = file("/Users/sadayoshitada/tmp/kaggle-261706-493f485a4663.json")
  region      = "asia-northeast1"
}

resource "google_compute_instance" "cem-tarou-instance" {
  name         = "cem-tarou-instance"
  machine_type = "f1-micro"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      size  = 20
      type  = "pd-standard"
      image = "centos-cloud/centos-7-v20210721"
    }
  }

  network_interface {
    network = "default"
    access_config {

    }
  }

  metadata = {
    "Name" = "cem-tarou-instance"
  }
}