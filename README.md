

![image](https://github.com/user-attachments/assets/e2d366d8-6bda-4cf0-98ec-d9df69d1e72f)

```
This project demonstrates how to provision a 3-Tier Architecture on AWS using Terraform. It includes a Public and Private subnet setup, EC2 instances, Internet Gateway, NAT Gateway, Security Groups, and two Application Load Balancers (ALBs).


## Setup Instructions
1. Clone the reposiory: git clone
2. Initialize Terraform: terraform init
3. Plan the Deployment: terraform plan
4. Apply Changes: terraform apply

## Key Components
Web:      	        EC2 + Auto Scaling Group + Public ALB
App:      	        EC2 + Auto Scaling Group + Private ALB
DB:       	        Amazon RDS (MySQL/PostgreSQL)
Network:   	        VPC, Subnets (Public/Private), NAT Gateway, Route Tables
Security: 	        Security Groups, IAM Roles
Terraform Backend:      S3 Remote State + DynamoDB Locking

## Features
✅ Infrastructure-as-Code using Terraform
✅ Auto Scaling Groups for Web and App tiers for dynamic scaling
✅ RDS as the persistent and secure backend database
✅ Private Subnets for App and DB layers (no public access)
✅ S3 + DynamoDB remote backend for secure and team-friendly Terraform state management
✅ Modular design using custom Terraform modules



![Uploading image.png…]()
