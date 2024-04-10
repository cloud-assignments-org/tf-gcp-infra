# Defining a Key Ring
resource "google_kms_key_ring" "webapp" {
  name     = "${var.kms_key_ring_name}-${random_string.key_ring_name_random_suffix.result}"
  location = var.region
}

# Defining Keys
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/kms_crypto_key

/**
Note:
CryptoKeys cannot be deleted from Google Cloud Platform. Destroying a Terraform-managed CryptoKey 
will remove it from state and delete all CryptoKeyVersions, rendering the key unusable, but will 
not delete the resource from the project. When Terraform destroys these keys, any data previously 
encrypted with these keys will be irrecoverable. For this reason, it is strongly recommended that 
you add lifecycle hooks to the resource to prevent accidental destruction.

An optional object can be passed along with the resource to prevent destroying keys
  lifecycle {
    prevent_destroy = true
  }

Since in this assignment we destroy the infra after every assignment, we need not worry about this.

Create a separate Customer-managed encryption keys (CMEK) for each of the following resources:
Virtual Machines
CloudSQL Instances
Cloud Storage Buckets

Attributes
rotation_period - (Optional) Every time this period passes, 
generate a new CryptoKeyVersion and set it as the primary. 
The first rotation will take place after the specified period. 
The rotation period has the format of a decimal number with up to 9 fractional digits, 
followed by the letter s (seconds). It must be greater than a day (ie, 86400).
**/
resource "google_kms_crypto_key" "vm" {
  name            = "${var.kms_vm_crypto_key_name}-${random_string.vm_key_name_random_suffix.result}"
  key_ring        = google_kms_key_ring.webapp.id
  rotation_period = var.kms_vm_crypto_key_rotation_period
}

resource "google_kms_crypto_key" "sql" {
  name            = "${var.kms_sql_crypto_key_name}-${random_string.sql_key_name_random_suffix.result}"
  key_ring        = google_kms_key_ring.webapp.id
  rotation_period = var.kms_sql_crypto_key_rotation_period
}

resource "google_kms_crypto_key" "storage" {
  name            = "${var.kms_storage_bucket_crypto_key_name}-${random_string.storage_key_name_random_suffix.result}"
  key_ring        = google_kms_key_ring.webapp.id
  rotation_period = var.kms_storage_bucket_crypto_key_rotation_period
}


resource "random_string" "key_ring_name_random_suffix" {
  length           = var.kms_key_names_random_string_length
  special          = var.kms_key_names_random_string_suffix_spl
}

resource "random_string" "vm_key_name_random_suffix" {
  length           = var.kms_key_names_random_string_length
  special          = var.kms_key_names_random_string_suffix_spl
}

resource "random_string" "sql_key_name_random_suffix" {
  length           = var.kms_key_names_random_string_length
  special          = var.kms_key_names_random_string_suffix_spl
}

resource "random_string" "storage_key_name_random_suffix" {
  length           = var.kms_key_names_random_string_length
  special          = var.kms_key_names_random_string_suffix_spl
}
