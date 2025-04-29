
This project demonstrates how to provision a scalable 3-Tier Architecture on AWS using Terraform. The setup follows a modular approach, organizing infrastructure into separate layers: VPC, Web, App, Database, IAM, Security Group. This ensures better manageability, reusability, and security while deploying cloud resources. By the end, you will have a fully automated, infrastructure-as-code (IaC) solution for hosting applications on AWS.

![image](https://github.com/user-attachments/assets/85a6bda8-c56e-42fa-9117-55e41db5c1d8)
 ```
## Architecture Overview:
We will deploy a three-tier architecture consisting of the following:
VPC (Core Layer): Contains public and private subnets.
Public Subnets: Web servers(ASG) and NAT Gateway.
Private Subnets: Application servers (EC2 instances) and Database (Amazon RDS).
Load Balancer: ALB to distribute traffic.
Security Groups: Restricted access at different layers

## Deployment steps:
1️⃣ Initialize Terraform: terraform init
2️⃣ Plan the Deployment: terraform plan
3️⃣ Apply the Configuration: terraform apply -auto-approve
4️⃣ Verify the Deployment: Check AWS Console for created resources. Validate EC2 instances, ALB, and RDS.
5️⃣ Destroy Infrastructure (Optional): terraform destroy -auto-approve

## Features
✅ Infrastructure-as-Code using Terraform
✅ Auto Scaling Groups for Web and App tiers for dynamic scaling
✅ RDS as the persistent and secure backend database
✅ Private Subnets for App and DB layers (no public access)
✅ S3 + DynamoDB remote backend for secure and team-friendly Terraform state management
✅ Modular design using custom Terraform modules

This foundation supports seamless scaling, cost optimization, and compliance readiness, providing a robust blueprint for modern cloud-native applications. Future enhancements like HTTPS, WAF, or secrets management can further strengthen production readiness.
