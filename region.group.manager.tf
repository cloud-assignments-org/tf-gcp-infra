# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_region_instance_group_manager

resource "google_compute_region_instance_group_manager" "webapp" {
  name   = "l7-xlb-backend-example"
  region = var.region
  # For your instance group, define an HTTP service 
  # and map a port name to the relevant port. 
  # The backend service of the load balancer forwards 
  # traffic to the named port.
  named_port {
    name = "http"
    port = var.app_port
    # this means, all traffic that are routed through to this instance group
    # maanger will be routed to the http port 80 in the 
    # VM instances that are managed by this instance group
    # since we add the tag "load-balanced-backed" to the instance template
    # and we allow all traffic in port 80 through the firewall rule,
    # We will be able to hit the vm, but one thing that needs to be checked is, 
    # the webapp service needs to be running on the same port
  }
  version {
    instance_template = google_compute_region_instance_template.webapp.id
    name              = "primary"
  }
  base_instance_name = "webapp-vm"

}
