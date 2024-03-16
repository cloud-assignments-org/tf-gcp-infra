variable "dns_webapp_record_name" {
    type = string
    description = "The DNS name this record set will apply to."
}

variable "dns_webapp_record_type" {
  type = string
  description = "The DNS record set type"
}

variable "dns_webapp_record_ttl" {
  type = number
  description = "The time-to-live of this record set (seconds)."
}

variable "dns_managed_zone_name" {
  type = string
  description = "A unique name for the resource."
}
