# Defining a Key Ring
resource "google_kms_key_ring" "webapp" {
    name = "webapp-key-ring"
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
    name = "vm-key"
    key_ring = google_kms_key_ring.webapp.id
    rotation_period = "2592000s"
}

resource "google_kms_crypto_key" "sql" {
    name = "sql-key"
    key_ring = google_kms_key_ring.webapp.id
    rotation_period = "2592000s"
}

resource "google_kms_crypto_key" "storage" {
    name = "storage-bucket-key"
    key_ring = google_kms_key_ring.webapp.id
    rotation_period = "2592000s"
}
