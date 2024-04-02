# Reserve an external IP address for the load balancer.
# We will pointing our domain to this external IP in our DNS zone
# Commented for now, since we will be using an ephemeral IP
# But required when we do it in production
# Keeping this commented for now
resource "google_compute_global_address" "load_balancer_ip" {
  name         = "load-balancer-ip"
  address_type = "EXTERNAL"
}
