##Deploying an Express.js Application on AWS EC2 with Terraform and Ansible

This README provides instructions for deploying an Express.js application on an AWS EC2 instance using Terraform for infrastructure provisioning and Ansible for configuration management.

Prerequisites

AWS account with appropriate permissions

Terraform installed

Ansible installed

GitLab repository containing the application

Project Structure

.
├── ansible
│ ├── inventory.ini
│ ├── playbook.yml
│ └── templates
│ └── automation_express_service.j2
└── terraform
├── main.tf
├── outputs.tf
└── variables.tf


Steps

1. Set up AWS credentials
   Configure your AWS credentials by running:
aws configure 

2. Deploy infrastructure with Terraform
Navigate to the terraform directory and initialize Terraform.

cd terraform
terraform init
terraform apply

3. Update Ansible inventory
   After the apply command completes, copy the public IP address from the Terraform outputs and update the ansible/inventory.ini file with the IP address.

[webapp]
webapp_instance ansible_host=<PUBLIC_IP> ansible_user=ec2-user ansible_ssh_private_key_file=<PATH_TO_PRIVATE_KEY> 4. Configure the EC2 instance with Ansible
Navigate to the ansible directory and run the playbook.

cd ../ansible
ansible-playbook -i inventory.ini playbook.yml

This playbook will:

Update the package manager

- Install required packages (Git, Node.js, and npm)

- Clone the application from the GitLab repository

- Install application dependencies

- Create a systemd service for the application

- Start and enable the systemd service

5. Access the application

The application should now be running on the EC2 instance. Access the application using the public IP address and port specified in the application configuration (default is 8080).

http://<PUBLIC_IP>:8080
