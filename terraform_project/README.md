# 🚀 Terraform AWS Infrastructure Project
## 🌐 Overview
This Terraform project creates a comprehensive AWS infrastructure including:

## 🏗️ Virtual Private Cloud (VPC) with public and private subnets

## 💻 EC2 instances in both public and private subnets

## 🎛️ EKS (Elastic Kubernetes Service) cluster setup (currently commented out)

## 🔒 Security groups for network access control

## 👮 IAM roles for EKS permissions

## 📂 Project Structure
.
├── .gitignore
├── LICENSE.txt
├── modules.json
├── main.tf (root module)
└── moduals/
    ├── ec2/ (EC2 instance module)
    │   ├── main.tf
    │   └── variable.tf
    ├── eks/ (EKS cluster module)
    │   ├── eks.tf
    │   ├── iam.tf
    │   └── variable.tf
    ├── private_subnet/ (Private subnet module)
    │   ├── main.tf
    │   └── variable.tf
    ├── public_subnet/ (Public subnet module)
    │   ├── main.tf
    │   └── variable.tf
    └── vpc/ (VPC module)
        ├── main.tf
        └── variable.tf
## 🔑 Key Components
## 🌍 Networking
  VPC: Created with CIDR block 10.0.0.0/16

  Subnets:

## 🌐 Public subnet for internet-facing resources

## 🔒 Private subnets for EKS nodes (10.0.2.0/24 and 10.0.3.0/24)

## 💻 Compute
EC2 Instances:

## ☁️ Public instance in the public subnet

## 🔐 Private instances in EKS subnets

## 🖼️ All instances use AMI ami-084568db4383264d4 (Amazon Linux 2)

## ⚙️ Instance type t3.medium

## 🔒 Security
Security Groups:

## 🛡️ One allowing ports 80, 443, 22, 8080 for TCP traffic

## 🔐 Pre-existing EKS security group (sg-08e20f527f2d68eb5) used for private instances

Key Pair: 🔑 Uses "deployer-key" with public key from local file

## ☸️ Kubernetes (Commented Out)
EKS cluster configuration with:

## 👮 IAM roles for cluster and nodes

## ⚖️ Node auto-scaling configuration

## 🌐 VPC integration

## 🛠️ Usage
Initialize Terraform:

```bash
terraform init
```
Review execution plan:

```bash
terraform plan
Apply changes:
```
```bash
terraform apply
To destroy resources:
```
```bash
terraform destroy
```
## 📋 Requirements
## ⚙️ Terraform installed

## 🔑 AWS credentials configured

## 🔐 Existing SSH key pair ("deployer-key")

## 📝 Notes
The RDS and some EKS-related resources are currently commented out in the configuration

The project uses the Mozilla Public License 2.0

Terraform state files are ignored in .gitignore

## 📤 Outputs
The configuration includes outputs for:

## 🌐 Subnet IDs

## � EKS cluster name (when uncommented)

## 🎨 Customization
You can modify the following variables in the respective modules:

## 🖼️ AMI IDs

## ⚙️ Instance types

## 🔢 CIDR blocks

## 🔐 Security group rules

## ⚖️ EKS node scaling parameters

This version maintains all the technical information while making it more visually appealing with relevant emojis! 😊
