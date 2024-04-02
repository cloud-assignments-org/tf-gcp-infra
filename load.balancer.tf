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

Check Interval
This is the frequency at which the health checks are performed. 
Setting it too low might not give enough time for transient issues 
to resolve themselves.

Recommended Check Interval: 1 minute (60 seconds). This ensures 
that the system isn't constantly in a state of flux and provides 
a buffer for temporary issues to be resolved.

Unhealthy Threshold
This determines how many consecutive failed health checks are needed 
before an instance is considered unhealthy and subject to replacement.
Given your application's characteristics, it's wise to allow for some 
failures before taking action, to avoid reacting to transient or 
insignificant issues.

Recommended Unhealthy Threshold: 2-3 consecutive failures. 
This setting means that an instance must fail the health check 2-3 
times in a row before being considered unhealthy, providing a cushion 
against temporary glitches.

Health Check Timeout
This is the amount of time allowed for a response to a health check. 
If your application response times can vary, especially under load,
you'll want to ensure the timeout isn't too aggressive.

Recommended Timeout: At least 10 seconds. This should be more than 
enough if the application is operational but should be adjusted based 
on observed response times under load.

Healthy Threshold
This is the number of consecutive successful health checks required 
to consider an instance healthy again after it has been marked 
unhealthy. This parameter is crucial to ensure that an instance is 
genuinely recovered and not oscillating between healthy and unhealthy 
states.

Recommended Healthy Threshold: 2 consecutive successes. 
This confirms that the instance is consistently responding as 
expected before it is marked healthy.

*/

resource "google_compute_health_check" "webapp" {
  name               = "webapp-global-health-check"
  check_interval_sec = 60
  healthy_threshold  = 2
  http_health_check {
    port_specification = "USE_SERVING_PORT"
    request_path       = "/healthz"
  }
  timeout_sec         = 10
  unhealthy_threshold = 3
}

resource "google_compute_backend_service" "webapp" {
  name                  = "webapp-global-backend-service"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  health_checks         = [google_compute_health_check.webapp.id]
  protocol              = "HTTP"
  session_affinity      = "NONE"
  timeout_sec           = 30
  backend {
    group           = google_compute_region_instance_group_manager.webapp.instance_group
    balancing_mode  = "UTILIZATION"
    capacity_scaler = 1.0
  }
  depends_on = [google_compute_region_instance_group_manager.webapp]
}

resource "google_compute_url_map" "webapp" {
  name            = "webapp-url-map"
  default_service = google_compute_backend_service.webapp.id
  depends_on = [ google_compute_backend_service.webapp  ]
} 

resource "google_compute_managed_ssl_certificate" "webapp_lb" {
  name = "webapp-ssl-cert"
  
  managed {
    domains = [var.domain_name]
  }
}

resource "google_compute_target_https_proxy" "webapp" {
  name    = "webapp-target-htttp-proxy"
  url_map = google_compute_url_map.webapp.id
  ssl_certificates = [
    google_compute_managed_ssl_certificate.webapp_lb.name
  ]
  depends_on = [
    google_compute_managed_ssl_certificate.webapp_lb
  ]
}

/*
GOOGLE_COMPUTE_FORWARDING_RULE

A ForwardingRule resource specifies which pool of target virtual machines to 
forward a packet to if it matches the given [IPAddress, IPProtocol, portRange] 
tuple.1
*/

resource "google_compute_global_forwarding_rule" "webapp" {
  name       = "l7-xlb-forwarding-rule"
  depends_on = [google_compute_subnetwork.lb_proxy_only]
  ip_protocol           = "TCP"
  load_balancing_scheme = "EXTERNAL_MANAGED"
  port_range            = "443"
  target                = google_compute_target_https_proxy.webapp.id
  ip_address            = google_compute_global_address.load_balancer_ip.id
}
