# Terraform-Managed Cloud-Native Application Deployment

## Project Overview

This project demonstrates a sophisticated cloud-native application deployment orchestrated with Terraform on Google Cloud Platform (GCP). It highlights a fully automated, secure, and scalable infrastructure that leverages a variety of GCP services to support a resilient web application.

## Architecture Description

The architecture is designed to ensure security, scalability, and high availability:

- **Virtual Private Cloud (VPC)**: Configured with multiple subnets to segregate backend services, database services, and manage traffic flow securely within the US-Central region.
- **Managed Instance Group**: Hosts the application's backend services, ensuring they scale automatically based on traffic demands.
- **Cloud SQL**: Provides managed SQL databases with private connectivity, ensuring data integrity and security.
- **Cloud DNS and SSL**: Uses Google-managed SSL certificates and DNS configuration for secure and reliable user access.
- **GitHub Actions and HashiCorp Packer**: Integrates CI/CD pipelines for continuous integration, automated testing, and building of custom machine images.
- **Google Cloud Pub/Sub and Cloud Functions**: Utilizes event-driven architecture for efficient user account management and email notification services.
- **Security with IAM and KMS**: Implements strict IAM roles and uses Key Management Service for encryption key management, securing data access and compliance.

## Key Technologies

- **Google Cloud Platform**: Extensive use of GCP services including VPC, Cloud SQL, Cloud Functions, Pub/Sub, Cloud DNS, and IAM.
- **Terraform**: Used for provisioning and managing all cloud resources as code, ensuring infrastructure consistency and reproducibility.
- **GitHub Actions**: Automates CI/CD workflows, facilitating continuous testing, integration, and deployment.
- **Packer**: Builds custom machine images configured with all necessary software dependencies, optimizing deployment and runtime efficiency.

## CI and DevOps Practices

- **Continuous Integration**: Automatically tests and builds application code changes, ensuring high code quality and reducing integration problems.
- **Infrastructure as Code**: Terraform scripts define and control the provisioning of all infrastructure components, enhancing deployment speed and infrastructure visibility.

## Setup and Configuration

Detailed instructions on how to clone the repository, install dependencies, and deploy the application using Terraform:

1. **Environment Setup**: Guide on setting up the `gcloud` CLI, authenticating your session, and configuring Terraform with GCP.
2. **Infrastructure Deployment**: Step-by-step commands to initialize Terraform, plan the deployment, and apply the configuration to provision all resources.

## Security Measures

Explanation of the security configurations and practices implemented to protect the application and its data, including VPC settings, IAM roles, and the use of GCP's Key Management Service.

## Monitoring and Operations

Overview of the logging and monitoring setup using Google Cloud's operations suite, ensuring ongoing visibility into application performance and operational health.

## Diagrams

- **High-Level Architecture Diagram**: Illustrates the complete cloud infrastructure setup and interconnections between components.![Terraform Architecture](https://github.com/cloud-assignments-org/tf-gcp-infra/assets/113069126/b6acda47-da1a-49aa-94b7-93170eacaaff)
> Architecture diagram credits : https://github.com/CSYE-6225-hemanthnvd

- **CI/CD Workflow Diagram**: Shows the automation flow from code commit to production deployment.

## Contact

- **Name**: Dhruv Parthasarathy
- **Email**: parthasarathy.d@northeastern.edu
- **LinkedIn**: https://www.linkedin.com/in/parthasarathydhruv/
- **GitHub**: https://github.com/parthasarathydNU
