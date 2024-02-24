resource "random_id" "db_name_suffix" {
  byte_length = 4
}

# Creating the database service / machine
resource "google_sql_database_instance" "instance" {
  name                = "private-instance-${random_id.db_name_suffix.hex}"
  region              = var.region
  database_version    = "POSTGRES_15"
  deletion_protection = false
  depends_on          = [google_service_networking_connection.default]

  settings {
    # tier = "db-f1-micro" <----- use this for submission
    tier = "db-custom-2-13312"
    ip_configuration {
      ipv4_enabled    = false
      private_network = google_compute_network.vpc.self_link
    }
    availability_type = "REGIONAL"
    disk_type         = "PD_SSD"
    disk_size         = 100
  }
}

# Creating the database
resource "google_sql_database" "database" {
  name     = "webapp"
  instance = google_sql_database_instance.instance.name
}

# Random password generator
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# Creating a user
resource "google_sql_user" "users" {
  name     = "webapp"
  instance = google_sql_database_instance.instance.name
  password = random_password.password.result
}
