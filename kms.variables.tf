variable "kms_key_ring_name" {
  type = string
}

variable "kms_vm_crypto_key_name" {
  type = string
}

variable "kms_vm_crypto_key_rotation_period" {
  type = string
}

variable "kms_sql_crypto_key_name" {
  type = string
}

variable "kms_sql_crypto_key_rotation_period" {
  type = string
}

variable "kms_storage_bucket_crypto_key_name" {
  type = string
}

variable "kms_storage_bucket_crypto_key_rotation_period" {
  type = string
}

variable "kms_key_names_random_string_length" {
  type = number
  default = 5
}

variable "kms_key_names_random_string_suffix_spl" {
  type = bool
  default = false
}
