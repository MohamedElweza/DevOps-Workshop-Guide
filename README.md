# DevOps Workshop Project Guide

This document is a complete and simple guide to help you set up and understand the full DevOps workflow we applied in the workshop. It’s designed for anyone who wants to replicate the projects from scratch and gain hands-on experience with modern DevOps tools.

---

## Table of Contents
1. [Overview](#overview)
2. [Project 1: Manual Deployment On-Premises](#project-1)
3. [Project 2: Automated Deployment with Shell Scripts](#project-2)
4. [Project 3: On-Premises Automation with Ansible](#project-3)
5. [Project 4a: AWS EC2 Deployment (Manual Setup)](#project-4a)
6. [Project 4b: AWS Native Services Deployment](#project-4b)
7. [Project 5: Containerization with Docker](#project-5)
8. [Project 6: Kubernetes Deployment](#project-6)
9. [Project 7: CI/CD with Jenkins & ArgoCD](#project-7)
10. [Project 8: Terraform for AWS Deployment](#project-8)
11. [Project 9: Monitoring with Prometheus & Grafana](#project-9)
12. [Resources & Notes](#resources)

---

## Overview
We deployed a **multi-tier Java web application** with the following services:
- **Tomcat (App Server)**
- **MySQL (Database)**
- **Memcached (Caching)**
- **RabbitMQ (Message Broker)**
- **Nginx (Reverse Proxy)**

Each project built on the one before it, moving from manual deployment to full CI/CD in the cloud using Infrastructure as Code.

---

## Project 1: Manual Deployment On-Premises
**Tools:** Vagrant + VirtualBox + Manual Configuration  
**What We Did:**
- Created 5 separate VMs using Vagrant.
- Manually installed and configured MySQL, RabbitMQ, Tomcat, Memcached, and Nginx.
- Connected services to form a working architecture.

**GitHub Repo:** [Multi-Tier Java Web Application](https://github.com/MohamedElweza/Multi-Tier-Java-Web-Application)

---

## Project 2: Automated Deployment with Shell Scripts
**Tools:** Vagrant + Bash Scripts  
**What We Did:**
- Created scripts to automatically install and configure each service.
- Provisioned machines using `vagrant up`.
- Made the setup reproducible and consistent.

**Directory:** `Bash Scripts/`

---

## Project 3: On-Premises Automation with Ansible
**Tools:** Vagrant + Ansible + Roles  
**What We Did:**
- Used Ansible to replace manual scripting.
- Created reusable roles for each service.
- Defined inventory and site playbook for orchestration.

**GitHub Repo:** [Ansible Deployment Repo](https://github.com/MohamedElweza/Automating-Multi-Tier-Java-Web-Application-Deployment-with-Ansible)

---

## Project 4a: AWS EC2 Deployment (Manual Setup)
**Tools:** AWS Console + AWS CLI  
**What We Did:**
- Launched EC2 instances for each service.
- Installed and configured each service with scripts.
- Defined security groups for isolated and secure communication between services.
- Deployed the Java app and connected it with RabbitMQ, Memcached, and MySQL manually.

**Directory:** `AWS Scripts/`

---

## Project 4b: AWS Native Services Deployment
**Tools:** AWS Console + AWS Services  
**What We Did:**
- Replaced VMs with AWS managed services:
  - **Amazon RDS** for MySQL
  - **ElastiCache** for Memcached
  - **Amazon MQ** for RabbitMQ
  - **Elastic Beanstalk / ECS** for app deployment
- Configured IAM, networking, and security groups.
- Used automation scripts to connect all services together.

---

## Project 5: Containerization with Docker
**Tools:** Docker + Docker Compose  
**What We Did:**
- Containerized all services including the Java application, MySQL, RabbitMQ, Memcached, and Nginx.
- Created Dockerfiles and a `docker-compose.yml` to spin up the entire stack locally with one command.
- Enabled easy testing and development with isolated containers.

**Directory:** `Docker Files/`

---

## Project 6: Kubernetes Deployment
**Tools:** Docker + Kubernetes + kubectl  
**What We Did:**
- Wrote YAML files to deploy all components:
  - Deployments & Services for MySQL, RabbitMQ, Memcached, and the App
  - Kubernetes Secrets for sensitive data
  - LoadBalancer and NodePort for external access
- Ensured dependencies readiness using initContainers.

**GitHub Repo:** [K8s Multi-Tier App](https://github.com/MohamedElweza/K8s-MultiTier-App)

---

## Project 7: CI/CD with Jenkins & ArgoCD
**Tools:** Jenkins + ArgoCD + GitHub  
**What We Did:**
- Used Jenkins to build Docker images and push them to registry.
- Configured pipelines to trigger on code updates.
- Installed ArgoCD on Kubernetes and connected it to GitHub repo.
- Enabled GitOps-based deployment via ArgoCD.

> **Best Practice:** Jenkins handles build, ArgoCD handles deployment.

**GitHub Repo:** [CI/CD with Jenkins & ArgoCD](https://github.com/MohamedElweza/CI-CD-with-Jenkins-ArgoCD-for-Kubernetes-Deployment)

---

## Project 8: Terraform for AWS Deployment
**Tools:** Terraform  
**What We Did:**
- Wrote `.tf` files to define complete infrastructure (VPC, subnets, EC2, RDS, security groups).
- Used remote-exec and user data to automate configuration.
- Reproducible, version-controlled, and scalable deployment.

**Directory:** `Terraform files/`

---

## Project 9: Monitoring with Prometheus & Grafana
**Tools:** Prometheus + Grafana + Node Exporter  
**What We Did:**
- Installed and configured Prometheus to scrape metrics from services.
- Used Node Exporter and other exporters to monitor system and app metrics.
- Deployed Grafana dashboards to visualize the health and performance of the system.
- Integrated with Kubernetes and Docker where applicable.
**Directory:** `Monitoring/`
---

## Resources & Notes
- Minimum Recommended: **4 CPU / 8 GB RAM** (especially for Jenkins, ArgoCD, Kubernetes)
- Use least-privilege **security groups** in AWS
- Add `k8s/` to `.gitignore` in CI/CD repo to avoid duplicate uploads
- Every project is modular and builds on the one before it
- Each project has its own GitHub repo or script directory for easy setup

---

## Final Words
This workshop gave us a complete DevOps learning experience—from manual setups to fully automated CI/CD pipelines in the cloud. Feel free to build on top of these projects by adding monitoring, observability, or Helm chart management. 💡🚀
