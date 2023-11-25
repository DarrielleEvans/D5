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
  - Security Group Ports: 8080, 8000, 22: The application will be accessed on port 8000, the instances are accessed on port 22, and Jenkins is accessed on port 8080.
## Step 3
- Setup the Jenkins Server
  - To deploy our app on a separate EC2 instance, we need to first log into the Jenkins server as the Jenkins user. Once there, we'll generate SSH keys. These keys are then shared         with the other instance, ensuring we can set up an SSH connection.
  -  Run the following commands to install the necessary software and packages to run the ci/cd pipeline.
  - sudo apt install -y software-properties-common: This installation provides the tools to manage software packages.
  - sudo add-apt-repository -y ppa:deadsnakes/ppa: The banking application uses python:3.7. Because this version is not installed in Ubuntu's standard repository, running this command     will add deadsnakes to the Ubuntu repository, which allows me to use the newer version of python to run the banking application.
  - sudo apt install -y python3.7: This command installs python version 3.7 on the instance needed to run the banking application.
  - sudo apt install -y python3.7-venv: This command installs the Python virtual environment to run Python.
## Step 4
- Setup Application Server
  - Run the following commands to install the necessary software and packages to run the application.
  - sudo apt install -y software-properties-common: This installation provides the tools to manage software packages.
  - sudo add-apt-repository -y ppa:deadsnakes/ppa: The banking application uses python:3.7. Because this version is not installed in Ubuntu's standard repository, running this command     will add deadsnakes to the Ubuntu repository, which allows me to use the newer version of python to run the banking application.
  - sudo apt install -y python3.7: This command installs python version 3.7 on the instance needed to run the banking application.
  - sudo apt install -y python3.7-venv: This command installs the Python virtual environment to run Python.
## Step 5
- Setup the Jenkins CI/CD pipeline
  -  I created a multibranch pipeline in Jenkins to work with my GitHub repository, the primary code source. Due to having two specifically    named Jenkins files in the repository, I accurately specified the names of these Jenkins files in the script path section of the       configuration. This setup ensures that Jenkins correctly identifies and utilizes the appropriate Jenkins file for each branch in the pipeline.
- Jenkinsv1 has the following stages:
  - Build: This stage prepares the environment for building/testing the application by setting up the Python virtual environment (python3.7 -m venv test), activating it, and installing the required dependencies listed in requirements.txt.  
  - Test: The testing stage installs and utilizes Pytest to run tests on the application. This stage tests if the homepage loads correctly       by expecting and checking for a 200 response code.
  - Deploy: This stage uses SSH to deploy the application on a remote server.
  - Remind: This stage alerts the engineer that the application should be live on the remote server.
  <img width="1069" alt="Screen Shot 2023-11-24 at 9 49 45 PM" src="https://github.com/DarrielleEvans/D5/assets/89504317/f29c1744-01fa-4c7e-b7c3-b28fff359def">

- Jenkinsfilev2 has the following stages:
  - Clean: This stage executes the pkill script, which terminates the Gunicorn process. This step is crucial for ensuring a smooth deployment of new code by preventing conflicts between different application versions.
  - Deploy: This stage uses SSH to deploy the new version of the application on a remote server.
# Additional Supporting Tools
# Troubleshooting
- When running Terraform apply to create the infrastructure, I tried to change the CIDR block IP ranges. Due to the vpc's dependencies, I could not apply the changes. I had to delete the dependencies by running Terraform destroy, then rerun Terraform plan and Terraform apply.
# Application Deployed
### Version 1 of the Application Deployed
<img width="1422" alt="Screen Shot 2023-11-24 at 10 13 00 PM" src="https://github.com/DarrielleEvans/D5/assets/89504317/590077fc-37d1-4bd8-88e2-2f23b3a51314">

# System Diagram
![D5 drawio](https://github.com/DarrielleEvans/D5/assets/89504317/9ecb9c5b-5869-4dcf-8ef8-bb151679a7bf)



# Optimization 
