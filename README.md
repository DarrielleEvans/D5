<h1 align="center">Deploy Banking App<h1> 
  
# Purpose
This deployment aims to deploy an application using Terraform to quickly spin up the infrastructure and Jenkins to create a ci/cd pipeline. The application was hosted on the same instance as the Jenkins server in previous deployments. However, in this current deployment, the application is being deployed on a dedicated instance via an SSH connection. This separation of the Jenkins server and the application instance enhances security, facilitates scalability, and simplifies future troubleshooting efforts
# Deployment Steps 
## Step 1 
- Plan the deployment
  - Create a deployment diagram using a professional diagramming tool like Draw.io
  - Diagram the deployment using a professional diagramming tool such as Draw.io.
  - Create a GitHub repository and upload source code and related files.
  - Identify the technology being utilized.

## Step 2
- Create the infrastructure using Terraform with the following resources:
  - 1 VPC: Used to establish a virtual cloud network to isolate resources and provide security specifically for this deployment.
  - 2 AZ's: Utilizing two Availability Zones enhances redundancy, as placing each subnet in a separate zone reduces the risk of a single                 failure affecting both
  - 2 Public Subnets: Deploying two public subnets to host an instance within each subnet.
  - 2 EC2's: Utilizing 2 instances to separate the Jenkins and application server to enhance security, decrease the likeliness of                         downtime, and support scalability if needed.
  - 1 Route Table: Utilizing a route table to route traffic to and from the subnets.
  - Security Group Ports: 8080, 8000, 22: The application will be accessed on port 8000, the instances are accessed on port 22.
# Additional Supporting Tools
# Troubleshooting
# Application Deployed
# System Diagram
# Optimization 
