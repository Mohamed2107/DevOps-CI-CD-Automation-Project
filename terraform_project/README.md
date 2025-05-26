# 🚀 Terraform Project

## 📘 Overview
> This project uses **Terraform** to manage and provision infrastructure as code.  
> It's designed to be **modular**, **reusable**, and **scalable**.

Includes:
- 🧱 VPC (Virtual Private Cloud)
- 🌐 Public Subnets
- ☸️ EKS (Elastic Kubernetes Service) cluster with worker nodes
- 🔐 Private Subnets
- 💻 EC2 Instances
- ⚙️ TDS (Custom Module - e.g., database or internal app)

---

## 📁 Project Structure

```bash
├── .gitignore
├── LICENSE.txt
├── modules.json
├── main.tf                 # Root module configuration
├── variables.tf            # Global variables
├── outputs.tf              # Output definitions
├── iam.tf                  # IAM roles and policies
└── moduals/
    ├── ec2/                # EC2 instance module
    │   ├── main.tf
    │   └── variable.tf
    ├── eks/                # EKS cluster module
    │   ├── eks.tf
    │   ├── iam.tf
    │   └── variable.tf
    ├── private_subnet/     # Private subnet module
    │   ├── main.tf
    │   └── variable.tf
    ├── public_subnet/      # Public subnet module
    │   ├── main.tf
    │   └── variable.tf
    └── vpc/                # VPC module
        ├── main.tf
        └── variable.tf
```
## 🔧 Modules Breakdown
### ☸️ EKS Cluster Details
#### 🏗️ Architecture
 - Control Plane: Managed by AWS in multiple AZs

- Worker Nodes: Auto-scaling group in private subnets

- Networking: Uses VPC CNI plugin for native AWS networking

#### 🔧 Configuration
```sh
module "eks" {
  source          = "./moduals/eks"
  subent1         = module.private_eks_subnet2.subnet_id
  subnet2         = module.private_eks_subnet.subnet_id
  max_node        = 4
  min_node        = 2
}
```

### 🧱 VPC Module (`moduals/vpc`)
- Creates the VPC  
- Configures routing tables  
- Adds Internet & NAT gateways

### 🌐 Public Subnet (`moduals/public_subnet`)
- Adds public subnets to the VPC  
- Attaches them to the Internet Gateway

### 🔐 Private Subnet (`moduals/private_subnet`)
- Secure subnets with **no internet access**  
- Typically used for databases or backend servers

### 💻 EC2 Module (`moduals/ec2`)
- Launches EC2 instances  
- Set AMI, instance type, key pair, and security groups

### ⚙️ TDS Module (`moduals/tds`)
- Custom service logic (e.g., internal tool or database)  
- Automates setup and provisioning

### 🧩 Step 1: 📥 Clone the Repository

```bash
# 📦 Clone the GitHub repository to your local machine
git clone https://github.com/Mohamed2107/terraform_project.git

# 📁 Navigate into the project directory
cd terraform_project
```

### ⚙️ Step 2: 🚀 Initialize Terraform
```bash
# 🔧 Initialize the Terraform working directory
terraform init
```
- 📥 This will download all required provider plugins.
- ⚙️ Sets up the Terraform backend (if configured).
### 🛠️ Step 3: 📝 Set Your Variables
. 🧾 Modify variable.tf or create a terraform.tfvars file with your desired values.
```bash
# Example terraform.tfvars content
vpc_cidr           = "10.0.0.0/16"
instance_type      = "t2.micro"
availability_zones = ["us-east-1a", "us-east-1b"]
```
### 🔍 Step 4: 🧪 Review the Terraform Plan
```bash
# 🔎 Preview the changes Terraform will make
terraform plan
```
- ✅ This will show what will be created or modified without making actual changes.
### 🚀 Step 5: ✅ Apply the Configuration
```bash
# 🚀 Deploy your infrastructure
terraform apply
```
- 🆗 You’ll be asked to confirm the changes. Type yes to proceed.

- 🏗️ Terraform will start provisioning the infrastructure.
## 💡 Why Use Modules?

| ✅ Feature      | 🔎 Description                                                                 |
|-----------------|-------------------------------------------------------------------------------|
| ♻️ Reusability  | Use the same logic across multiple environments or projects                   |
| 🧹 Maintainability | Isolated module logic simplifies updates and troubleshooting                |
| 📈 Scalability   | Easily extend infrastructure without rewriting everything                    |


