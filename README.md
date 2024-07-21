
# DevOps Assignment README

This repository contains a simple Node.js "Hello, World!" web application along with a Jenkins pipeline configured for CI/CD. The application is containerized using Docker, and Jenkins automates the build, test, and deployment processes. This setup is hosted on an AWS EC2 instance. A Terraform config is included to deploy infrastructure.

## Repository Structure
- **Dockerfile:** Defines the Docker image for the web application.
- **Jenkinsfile:** Configures the Jenkins pipeline for building, testing, and deploying the Docker container.
- **docker-compose.yml:** Defines a multi-container Docker application setup.
- **main.tf:** Terraform configuration file for provisioning infrastructure.
- **package.json:** Defines the dependencies and scripts for the Node.js application.
- **src/:** Contains the source code of the web application.
- **app.js:** The main JavaScript file for the application.
- **index.html:** The HTML file served by the web application.
- **README.md:** This file.
## Prerequisites
- AWS EC2 Instance: Ensure you have an EC2 instance running with a public IP address or DNS.
- Docker: Docker must be installed on the EC2 instance.
- Jenkins: Jenkins must be installed on the EC2 instance.
- Git: Git should be installed to clone the repository.
- Terraform: Terraform should be installed if using the main.tf for infrastructure provisioning.
- Node.js: Node.js should be installed if working with package.json and app.js.
- Security Group: Ensure the security group associated with your EC2 instance allows inbound traffic on the ports used by Jenkins (default port 8080) and Docker (port 80 for the application).
## Setting Up Jenkins on AWS EC2
1. Launch EC2 Instance
- Go to the AWS Management Console.
- Launch a new EC2 instance using an appropriate AMI (Amazon Machine Image) that supports your needs (e.g., Ubuntu).
- Configure the instance with sufficient resources (e.g., t2.micro for testing).

2. Connect to Your EC2 Instance
- Use SSH to connect to your EC2 instance >
>     ssh -i your-key.pem ec2-user@your-ec2-public-ip

3. Install Docker
- Update the package index and install Docker
>     sudo apt update
>     sudo apt install docker.io
- Start Docker and enable it to run on startup
>     sudo systemctl start docker
>     sudo systemctl enable docker

4. Install Jenkins
- Add the Jenkins repository and install Jenkins
>     sudo apt update
>     sudo apt install openjdk-11-jdk
>     wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
>     sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
>     sudo apt update
>     sudo apt install jenkins
- Start Jenkins and enable it to run on startup
>     sudo systemctl start jenkins
>     sudo systemctl enable jenkins
5. Configure Jenkins

- Open Jenkins in your browser: http://your-ec2-public-ip:8080
- Follow the setup wizard and install the suggested plugins.
- Configure Jenkins to access your GitHub repository.
-       Jenkins settings - /usr/bin/git

## Setting Up the Jenkins Pipeline

1. Create a New Pipeline Job  
- In Jenkins, navigate to **'New Item'**. 
- Enter a name for your job, select **'Pipeline'**, and click **'OK'**.

2. Configure the Pipeline
- In the pipeline configuration, scroll to the **'Pipeline'** section.
- Set **'Definition'** to **'Pipeline script from SCM'**.
- Choose **'Git'** as the SCM and provide the URL to your GitHub repository.
- Specify the **'Script Path'** as **'Jenkinsfile'**.

3. Save and Build
- Save the configuration.
- Click **'Build Now'** to trigger the pipeline.

## Building and Running the Docker Container Locally
1. Clone the Repository on the EC2 Instance
>     git clone https://github.com/alinaleem/hello-world-web-app.git
>     cd your-repo

2. Install Dependencies
- Ensure **'package.json'** is present in the root directory.
- Install the Node.js dependencies
>     npm Install

3. Build the Docker Image
>     sudo docker build -t hello-world-app .

4. Run the Docker Container
>      sudo docker run -d -p 80:80 hello-world-app

5. Access the Application
- Open a web browser and go to http://your-ec2-public-ip.
- You should see the "Hello, World!" message.

## Using Docker Compose (if applicable)
1. Start Docker Compose:
- Ensure **"docker-compose.yml'** is properly configured.
- Run Docker Compose to start the application:
>      sudo docker-compose up -d

2. Access the Application
- Open a web browser and go to http://your-ec2-public-ip.
- You should see the "Hello, World!" message.

## Provisioning EC2 Infrastructure with Terraform in AWS
- Copy PEM file to Current EC2 in which Terraform is installed
- Create an IAM Role with full access and assign it to the EC2 instance
1. Initialize Terraform
- Ensure main.tf is properly configured.
- Initialize Terraform:
>     terraform init
2. Validate Terraform Configuration
>     terraform validate
3. Plan Terraform Configuration
>     terraform plan
4. Apply Terraform Configuration
- Apply the configuration to provision resources
>     terraform apply

## Additional Details
- **Dockerfile:** The Dockerfile sets up an environment for the web application and ensures it runs correctly inside a container.
- **Jenkinsfile:** Defines the Jenkins pipeline that includes:
    -  **Checkout Code:** Clones the repository.
    -  **Build:** Builds the Docker image.
    -  **Test:** Runs a basic test to ensure the application is running.
    -  **Deploy:** Deploys the Docker container to the EC2 instance.
- **docker-compose.yml:** Defines a multi-container Docker application setup, if applicable.
- **main.tf:** Terraform configuration file for provisioning infrastructure, if applicable.
- **package.json:** Contains metadata about the Node.js application, including dependencies and scripts.
- **app.js:** Main JavaScript file for the application.
- **index.html:** HTML file served by the web application.

## Assumptions
- Jenkins is correctly set up and has access to your GitHub repository.
- Docker and Docker Compose are properly installed and configured on your EC2 instance.
- Terraform is properly installed and configured if used.
- Node.js is installed and configured if working with package.json and app.js.
- The EC2 instance’s security group allows inbound traffic on necessary ports.

## Troubleshooting
- Pipeline Errors: Check Jenkins logs for any errors. Ensure all necessary plugins are installed and configured correctly.
- Docker Issues: Verify Docker service is running, and check for port conflicts or permission issues.
- Docker Compose Issues: Check Docker Compose logs for errors.
- Terraform Issues: Review Terraform logs for any provisioning errors.
- AMI finder - https://cloud-images.ubuntu.com/locator/ec2/