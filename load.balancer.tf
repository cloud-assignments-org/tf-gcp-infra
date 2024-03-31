/*
Author: Dhruv Parthasarathy
./load.balancer.tf

This file shows you how to create the following regional external 
Application Load Balancer resources:
- HTTP health check
- Backend service with a managed instance group as the backend
- A URL map : Make sure to refer to a regional URL map if 
              a region is defined for the target HTTP(S) proxy. 
              A regional URL map routes requests to a regional 
              backend service based on rules that you define for the 
              host and path of an incoming URL. 
              A regional URL map can be referenced by a regional 
              target proxy rule in the same region only.
- SSL certificate (for HTTPS)
- Target proxy
- Forwarding rule

Target HTTP(S) Proxy: This is a proxy that routes incoming HTTP(S) 
requests to backend services or backend buckets according to the URL map.
If this proxy is regional, it means it's configured to serve traffic for a 
specific region.

Importance of Matching Regions: When your target HTTP(S) proxy 
is regional (meaning it serves a specific geographic area), 
the URL map you use should also be regional and correspond to the same region. 
This ensures that your routing rules are appropriately localized and 
can efficiently direct traffic to the closest or most relevant backend services.

In the context of setting up an external application load 
balancer in Google Cloud, you're essentially being guided to 
ensure that your load balancing components are regionally coherent.
This means if your target proxy is set up for a particular region, 
your URL map should also be for that same region to ensure proper 
routing and performance optimization of your application traffic.
*/

/*
HEALTH CHECK RESOURCE
*/
resource "google_compute_region_health_check" "webapp" {
  name               = "l7-xlb-basic-check"
  check_interval_sec = 5
  healthy_threshold  = 2
  http_health_check {
    port_specification = "USE_SERVING_PORT"
    proxy_header       = "NONE"
    request_path       = "/healthz"
  }
  region              = var.region
  timeout_sec         = 5
  unhealthy_threshold = 2
}

/*
Regional backend service : 
https://cloud.google.com/compute/docs/reference/rest/v1/regionBackendServices

A backend service defines how Google Cloud load balancers distribute traffic. 
The backend service configuration contains a set of values, such as the protocol 
used to connect to backends, various distribution and session settings, 
health checks, and timeouts. These settings provide fine-grained control over
how your load balancer behaves.
*/
resource "google_compute_region_backend_service" "webapp" {
  name                  = "l7-xlb-backend-service"
  region                = var.region
  load_balancing_scheme = "EXTERNAL_MANAGED"
  health_checks         = [google_compute_region_health_check.webapp.id]
  protocol              = "HTTP"
  session_affinity      = "NONE"
  timeout_sec           = 30
  backend {
    group           = google_compute_instance_group_manager.webapp.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
}

/*
URL Map

Regional URL Map: A URL map is a set of rules that 
define how incoming requests are routed to backend services or backend buckets. 
A regional URL map is one that is specific to a particular region, 
as opposed to a global URL map, which is not tied to any specific region.

We have optional rules and paths that we can check to route traffic to different
backend services, but here since we don't have any separation, 
we stick to the default
*/
resource "google_compute_region_url_map" "webapp" {
  name            = "regional-l7-xlb-map"
  region          = var.region
  default_service = google_compute_region_backend_service.webapp.id

}

/*
REGION_TARGET_PROXY
The google_compute_region_target_http_proxy resource in Google Cloud 
is a regional component that acts as a regional HTTP(S) load balancer's 
target proxy. 

What is a Proxy ? 
A proxy, in the context of computer networks, acts as an intermediary between 
a client and a server. It receives requests from clients, forwards them to 
the server, and then relays the server's response back to the client. 
Proxies are used for various purposes, such as improving performance 
through caching, enforcing policies, providing anonymity for users, and 
balancing load among several servers.

A target proxy in cloud computing, particularly in the context of 
load balancing, is a specific type of proxy that forwards client 
requests to an appropriate backend service based on the configurations 
and rules defined in a URL map or similar routing mechanism. 

Load Balancing: A target proxy is a component in a load balancing 
configuration that receives incoming traffic and uses a URL map to 
decide how to distribute the traffic across various backend services.

Protocol-Specific: There are different types of target proxies for different 
protocols, such as HTTP(S) target proxies for web traffic and SSL target 
proxies for encrypted traffic.

Integration with URL Maps: Target proxies use URL maps to make routing 
decisions. The URL map defines rules based on request attributes 
(like URL paths) that determine which backend service should handle the request.
*/

/*
We need to use a regional https target proxy since we need to enable SSL 
However to start with setting this up , we use a http target proxy
*/
resource "google_compute_region_target_http_proxy" "webapp" {
  name    = "l7-xlb-proxy"
  region  = var.region
  url_map = google_compute_region_url_map.webapp.id
}

/*
GOOGLE_COMPUTE_FORWARDING_RULE

A ForwardingRule resource specifies which pool of target virtual machines to 
forward a packet to if it matches the given [IPAddress, IPProtocol, portRange] 
tuple.1
*/

resource "google_compute_forwarding_rule" "webapp" {
  name       = "l7-xlb-forwarding-rule"
  depends_on = [google_compute_subnetwork.lb_proxy_only]
  region     = var.region

  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "80"
  target                = google_compute_region_target_http_proxy.webapp.id
  network               = google_compute_network.vpc.id
  ip_address            = google_compute_address.load_balancer_ip.id
  network_tier          = "STANDARD"
}
