# 🚀 ArgoCD Project

This repository contains Kubernetes manifests for deploying a full-stack application using **ArgoCD**. The project is divided into three main components:

- 🔧 **Back-end**
- 🎨 **Front-end**
- 🗄️ **SQL Database**

---

## 📁 Repository Structure
```sh
.
├── k8s_back/
│ ├── backend-deployment.yml # Back-end deployment definition
│ ├── backend-svc.yml # Back-end ClusterIP service
│ └── nodepo.yml # NodePort service for back-end
│
├── k8s_front/
│ ├── front_deployment.yaml # Front-end deployment definition
│ ├── mysql.yml # MySQL (related to front-end if needed)
│ └── nodeport_front.yaml # NodePort service for front-end
│
├── k8s_sql/
│ ├── deployment-sql.yml # SQL database deployment
│ ├── pvc-sql.yml # PersistentVolumeClaim for database
│ ├── pv-sql.yml # PersistentVolume definition
│ └── service-sql.yml # Service for internal DB access
```

---

## 📦 Deployment Instructions

### 1️⃣ ArgoCD Setup
Ensure **ArgoCD** is installed and configured on your Kubernetes cluster.  
📘 [ArgoCD Docs](https://argo-cd.readthedocs.io/)

### 2️⃣ Connect Repository
- Add this GitHub repository to ArgoCD.
- Create a new ArgoCD Application pointing to this repo's root directory.
- ArgoCD will auto-sync and deploy the manifests.

### 3️⃣ Sync and Deploy
- Use ArgoCD's **UI** or `argocd app sync <app-name>` to trigger deployment.
- All services (back-end, front-end, and SQL) will be created.

---

## 🌐 Accessing Services

- **Front-End & Back-End**  
  Access externally via NodePort services:
  - `nodeport_front.yaml`
  - `nodepo.yml`

- **SQL Database**  
  Access internally via the ClusterIP service defined in `service-sql.yml`.

---

## 📝 Notes

- ✅ Update all image versions, storage classes, and configs for your environment.
- 👀 Monitor the ArgoCD UI for deployment and health status.
- ⚙️ Modify `mysql.yml` as needed based on app requirements.

---

## 🧰 Troubleshooting

- 📊 Check ArgoCD logs (`argocd app logs <app-name>`) for deployment issues.
- 🔍 Use `kubectl` to inspect pod, service, and volume status.
- 📦 Ensure PVCs are correctly bound to available PVs.

---

## 🤝 Contribution

Contributions are welcome! 🎉

- 📂 Fork this repo
- 🛠 Submit issues or pull requests
- 🧪 Please test changes in a dev cluster before production use

---
