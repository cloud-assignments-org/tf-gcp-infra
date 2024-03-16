/**
https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set#binding-a-dns-name-to-the-ephemeral-ip-of-a-new-instance
**/
resource "google_dns_record_set" "webapp" {
  name = var.dns_webapp_record_name
  type = var.dns_webapp_record_type
  ttl  = var.dns_webapp_record_ttl

  managed_zone = data.google_dns_managed_zone.public-zone.name

  rrdatas = [google_compute_instance.app_instance.network_interface[0].access_config[0].nat_ip]
}

data "google_dns_managed_zone" "public-zone" {
  name = var.dns_managed_zone_name
}
