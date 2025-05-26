# 🚀 K3s Cluster Automation with Ansible

## 📖 Overview

This Ansible role automates the deployment of a K3s (lightweight Kubernetes) cluster, including both master and worker nodes. K3s is a certified Kubernetes distribution designed for resource-constrained environments.

## 🧩 Features

- **Single-command K3s installation** on master nodes
- **Automatic token extraction** for worker node joining
- **Proper permission configuration** for K3s files
- **Cluster verification** with kubectl commands
- **IP address and token collection** for easy worker node setup

## 📂 Project Structure
```sh
k3s-ansible/
├── roles/
│ ├── k3s_master/ # Master node configuration
│ │ ├── tasks/
│ │ │ └── main.yml # Master installation tasks
│ │ ├── defaults/
│ │ │ └── main.yml # Default variables
│ │ └── vars/
│ │ └── main.yml # Role variables
│ └── k3s_worker/ # Worker node configuration
│ ├── tasks/
│ │ └── main.yml # Worker joining tasks
│ └── handlers/
│ └── main.yml # Worker handlers
├── inventory/ # Inventory files
├── test.yml # Test playbook
└── README.md # This documentation
```

## ⚙️ Requirements

- Ansible 2.9+
- Target servers with:
  - Ubuntu/Debian/CentOS
  - SSH access
  - Root/sudo privileges
- Internet access for K3s installation

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone https://github.com/Mohamed2107/DevOps-CI-CD-Automation-Project.git
cd DevOps-CI-CD-Automation-Project/ansible
```
2. Configure Inventory
Edit or create an inventory file with your nodes:

```sh
[k3s_masters]
master1 ansible_host=192.168.1.10 ansible_user=ubuntu

[k3s_workers]
worker1 ansible_host=192.168.1.11 ansible_user=ubuntu
worker2 ansible_host=192.168.1.12 ansible_user=ubuntu
```
3. Install K3s Master
```bash
ansible-playbook -i inventory/test.ini test.yml
```
4. Join Worker Nodes
After master installation, use the token from /tmp/k3s_token.txt to join workers.

🔧 Role Variables
Master Node Variables
Available in roles/k3s_master/defaults/main.yml:

yaml
# Example variables (customize as needed)
k3s_version: "latest"
k3s_install_url: "https://get.k3s.io"
📜 Example Playbook
```sh
yaml
- hosts: k3s_masters
  become: true
  roles:
    - role: k3s_master

- hosts: k3s_workers
  become: true
  roles:
    - role: k3s_worker
  vars:
    k3s_master_url: "https://{{ master_ip }}:6443"
    k3s_token: "{{ master_token }}"
```
### 🔍 Verification
The role automatically:

- Runs kubectl get nodes to verify cluster status

- Saves master node IP to /tmp/k3s_ip.txt

- Saves join token to /tmp/k3s_token.txt

### ⚠️ Important Notes
- The role sets liberal permissions (666/777) for demonstration - tighten these for production

- K3s master requires ports 6443 (API) and 8472 (Flannel) to be open

- For HA setups, additional configuration is needed

### 🔄 CI/CD Integration
This role can be integrated with:

- GitHub Actions

- GitLab CI/CD

- Jenkins pipelines

- Ansible Tower/AWX
