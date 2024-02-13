# tf-gcp-infra
This assignment will focus on setting up our networking resources such as Virtual Private Cloud (VPC), Internet Gateway, Route Table, and Routes. We will use Terraform for infrastructure setup and tear down.

### GCloud APIs enabled

1. Compute Engine API : Required while setting up the VPC
- The Compute Engine API allows you to create, configure, and manage Compute Engine instances that reside within a VPC. 
- When you create a Compute Engine instance, you can use the Compute Engine API to configure its network interfaces, including assigning it to a specific VPC and subnet, and setting up private and public IP addresses. This level of control is necessary for detailed network planning and security.
- The Compute Engine API allows you to manage firewall rules that control ingress and egress traffic to instances within your VPCs. 
- While specific to VPC management tasks, such as creating VPCs, subnets, and VPNs, are handled by the VPC Network API, the Compute Engine API is integral to deploying and managing resources that utilize the VPC.

### Commands to create subnet

```shell
# create the vpc
gcloud compute networks create vpc-1 --project=tf-gcp-infra-414120 --description=This\ is\ the\ first\ VPC\ for\ the\ assignment --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

# create subnet 1
gcloud compute networks subnets create webapp --project=tf-gcp-infra-414120 --description=Subnet\ for\ the\ web\ application --range=10.0.0.0/24 --stack-type=IPV4_ONLY --network=vpc-1 --region=us-east1

#create subnet 2
gcloud compute networks subnets create db --project=tf-gcp-infra-414120 --description=Subnet\ for\ the\ database --range=10.0.1.0/24 --stack-type=IPV4_ONLY --network=vpc-1 --region=us-east1
```

### Route

Next we craete a route `0.0.0.0/0` to the vpc and try to map it to the webapp subnet

```shell
gcloud beta compute routes create zero-for-webapp --project=tf-gcp-infra-414120 --network=vpc-1 --priority=1000 --tags=access-internet --destination-range=0.0.0.0/0 --next-hop-gateway=default-internet-gateway
```

We add the tag `access-internet` to it, so when we create instances within the webapp subnet, we need to also add the tag `access-internet` to those instances. This will ensure that only the instances within the webapp subnet have access to this route. 

In summary, while the route to 0.0.0.0/0 is applied at the VPC level, it impacts the 'webapp' subnet by providing a path for internet connectivity. The specific mapping to the 'webapp' subnet can be further controlled and secured using network tags and firewall rules, allowing for precise control over which instances can send and receive traffic through this route.

## Configuring Terraform

**Define the Terraform Configuration**

Create main.tf to specify your GCP resources and provider settings. This foundational step outlines what resources Terraform will manage.

**Specify Provider Credentials**

Use a service account key for Terraform to authenticate with GCP. The path to this key is referenced in your provider configuration, enabling Terraform to interact with your GCP resources.

**Using Variables for Dynamic Configuration**

Declare variables in variables.tf for elements like project ID, region, and credentials file path. This enhances the flexibility of your configurations.

**Assign Values to Variables**

Populate terraform.tfvars with values for each variable defined. This centralizes configuration values, making your setup reusable and easier to maintain.

**Import Existing Resources**

Utilize terraform import to bring already existing GCP resources under Terraform management. This step aligns Terraform's state with your current GCP environment without altering existing infrastructure.

**Plan Infrastructure Changes**

Execute terraform plan to review changes before they are applied. This critical step ensures that you're aware of and can approve all modifications Terraform will make.

**Saving the Execution Plan**

Optionally, save the output of terraform plan to a file using the -out option. This guarantees that terraform apply executes exactly what was planned, enhancing predictability.

**Applying the Plan**

Use terraform apply to make the planned changes to your infrastructure. This final step updates your GCP resources to match your Terraform configuration.


## Google cloud resources that can be imported

Terraform supports importing a wide range of Google Cloud Platform (GCP) resources. 

Commonly used GCP resources that you can import into Terraform:

```
Compute Engine Resources:

Instances: google_compute_instance
Disks: google_compute_disk
Networks: google_compute_network
Subnetworks: google_compute_subnetwork
Firewall rules: google_compute_firewall

Google Kubernetes Engine (GKE):

Clusters: google_container_cluster
Node Pools: google_container_node_pool

Cloud Storage:

Buckets: google_storage_bucket

Cloud SQL:

Instances: google_sql_database_instance
Databases: google_sql_database

VPC Networking:

VPCs: google_compute_network
Subnets: google_compute_subnetwork
VPN Gateways: google_compute_vpn_gateway
Routes: google_compute_route

IAM Resources:

Service Accounts: google_service_account
IAM Policies: google_project_iam_policy

Cloud DNS:

Managed Zones: google_dns_managed_zone
DNS Records: google_dns_record_set

Cloud Pub/Sub:

Topics: google_pubsub_topic
Subscriptions: google_pubsub_subscription

Cloud Functions:

Functions: google_cloudfunctions_function

BigQuery:

Datasets: google_bigquery_dataset
Tables: google_bigquery_table

For the most current and comprehensive list of GCP resources that Terraform can manage and import, along with detailed import syntax for each resource, you should refer to the Terraform Provider for Google Cloud documentation. The documentation provides extensive details on each resource, including examples of how to import existing resources into Terraform's state management.
