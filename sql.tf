resource "random_id" "db_name_suffix" {
  byte_length = 4
}

# Creating the database service / machine
resource "google_sql_database_instance" "instance" {
  name                = "private-instance-${random_id.db_name_suffix.hex}"
  region              = var.region
  database_version    = var.database_version
  deletion_protection = var.deletion_protection
  depends_on          = [google_service_networking_connection.default]
  encryption_key_name = google_kms_crypto_key.sql.id
  settings {
    tier              = var.tier
    availability_type = var.availability_type
    disk_type         = var.db_disk_type
    disk_size         = var.db_disk_size

    ip_configuration {
      ipv4_enabled    = var.ipv4_enabled
      private_network = google_compute_network.vpc.self_link
    }
  }
}

# Creating the database
resource "google_sql_database" "database" {
  name       = var.db_resource_name
  instance   = google_sql_database_instance.instance.name
  depends_on = [google_sql_user.user]
}

# Random password generator
resource "random_password" "password" {
  length           = var.password_length
  special          = var.password_special
  override_special = var.password_override_special
}

# Creating a user
resource "google_sql_user" "user" {
  name     = var.db_resource_name
  instance = google_sql_database_instance.instance.name
  password = random_password.password.result
}


# GCloud Secret to be used in Rolling Update Script through GCloud Secrets manager
resource "google_secret_manager_secret" "DB_HOST" {
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

  secret_id = "SQL_DB_HOST"
}

resource "google_secret_manager_secret_version" "DB_HOST_VALUE" {
  secret = google_secret_manager_secret.DB_HOST.id
  secret_data = google_sql_database_instance.instance.private_ip_address
}

resource "google_secret_manager_secret" "DB_PASSWORD" {
  replication {
    user_managed {
      replicas {
        location = var.region
      }
    }
  }

  secret_id = "SQL_DB_PASSWORD"
}

resource "google_secret_manager_secret_version" "DB_PASSWORD_VALUE" {
  secret = google_secret_manager_secret.DB_PASSWORD.id
  secret_data = google_sql_user.user.password
}
