<h1 align="center">Deploy Banking App<h1> 
  
# Purpose
This deployment aims to deploy an application using Terraform to quickly spin up the infrastructure and Jenkins to create a ci/cd pipeline. The application was hosted on the same instance as the Jenkins server in previous deployments. However, in this current deployment, the application is being deployed on a dedicated instance via an SSH connection. This separation of the Jenkins server and the application instance enhances security, facilitates scalability, and simplifies future troubleshooting efforts
# Deployment Steps 
## Step 1
- Create the infrastructure using Terraform with the following resources:
  - 1 VPC
  - 2 AZ's
  - 2 Public Subnets
  - 2 EC2's
  - 1 Route Table
  - Security Group Ports: 8080, 8000, 22
# Additional Supporting Tools
# Troubleshooting
# Application Deployed
# System Diagram
# Optimization 
