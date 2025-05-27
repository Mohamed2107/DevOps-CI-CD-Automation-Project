# DevOps CI/CD Automation Project

This project demonstrates a complete CI/CD automation workflow for deploying containerized frontend and backend applications to a Kubernetes cluster using GitOps principles.

## 👨‍💻 Authors

- Mohamed Mousa  
- Mohamed Abdallah

---

## 📚 Project Structure

This monorepo contains all the **Infrastructure as Code (IaC)** and **GitOps** configurations required to provision and deploy a cloud-native web application.

Application source code is separated into two GitHub branches:

- [Frontend Branch](https://github.com/Mohamed2107/web_develpoer/tree/front)
- [Backend Branch](https://github.com/Mohamed2107/web_develpoer/tree/backend)

---

## 🚀 Overview of the CI/CD Pipeline

### 1. **Code Commit & CI Trigger**
- Developers push frontend/backend code to GitHub.
- Jenkins is triggered automatically via a webhook.

### 2. **CI - Build & Security Scan**
- Jenkins builds a Docker image.
- The image is scanned using **Trivy** to detect vulnerabilities.
- Once passed, the image is pushed to **Docker Hub**.

### 3. **Infrastructure Automation**
- Infrastructure is provisioned using:
  - **Terraform**: for provisioning AWS VPC, Subnets, and EC2 instances.
  - **Ansible**: for configuring EC2 instances (e.g., installing dependencies, Docker, etc.).
  - Resources are deployed across multiple AWS availability zones for high availability.

- **Checkov** is used to perform security and compliance checks on the Terraform code.

### 4. **GitOps CD with ArgoCD**
- Kubernetes manifests are committed to GitHub.
- **ArgoCD** continuously monitors the GitHub repository and automatically syncs changes to the Kubernetes cluster.

### 5. **Kubernetes Deployment**
- The cluster is organized into three layers:
  - **Frontend**
  - **Backend**
  - **Database**

- Each component is deployed using Kubernetes manifests with persistent storage and services configured.

---

## 🔧 Tech Stack

| Layer              | Tool/Technology                     |
|--------------------|--------------------------------------|
| CI/CD              | Jenkins, ArgoCD                      |
| IaC                | Terraform, Ansible                   |
| Security           | Trivy, Checkov                       |
| Containerization   | Docker                               |
| Cloud              | AWS (EC2, VPC, Subnets)              |
| Orchestration      | Kubernetes                           |
| Source Control     | GitHub                               |

---

## 📁 Repository Structure

DevOps-CI-CD-Automation-Project/
│
├── terraform/ # AWS infrastructure provisioning
├── ansible/ # EC2 configuration
├── kubernetes/ # Deployment manifests for frontend, backend, db
├── argocd/ # GitOps app definitions
└── README.md

Application Repositories:
- **Frontend**: https://github.com/Mohamed2107/web_develpoer/tree/front  
- **Backend**: https://github.com/Mohamed2107/web_develpoer/tree/backend

---

## 📌 Future Improvements

- Add monitoring with Prometheus & Grafana.
- Integrate centralized logging using ELK/EFK stack.
- Auto-scaling policies for Kubernetes workloads.
