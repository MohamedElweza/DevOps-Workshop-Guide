
# 📊 Monitoring Multi-Tier Java Web Application with Prometheus & Grafana

## 🚀 Project Overview
This project sets up a **monitoring system** for a multi-tier Java web application using **Prometheus, Grafana, and Node Exporter**. It allows us to track system performance, resource utilization, and detect potential issues in real-time.

## 🎯 Why Monitoring?
✅ **Real-time Performance Tracking** – Keep an eye on server health and application metrics.  
✅ **Quick Issue Detection** – Identify bottlenecks and resolve issues faster.  
✅ **Scalability Insights** – Understand resource consumption for better scaling decisions.  

## 🛠 Tech Stack
- **Prometheus** – Metrics collection and alerting  
- **Grafana** – Data visualization and dashboards  
- **Node Exporter** – System metrics exporter  
- **Docker & Docker Compose** – Service management  

## 📂 Project Structure
```
📂 /
 ├── prometheus/
 │   ├── prometheus.yml
 ├── node_exporter/
 │   ├── docker-compose.yml
 ├── grafana/
 │   ├── docker-compose.yml
 ├── README.md
```

## 🔧 Setup Instructions

### 1️⃣ **Deploy Node Exporter (VM2)**
```bash
mkdir node_exporter && cd node_exporter
nano docker-compose.yml
```
Paste the following:
```yaml
version: '3.8'
services:
  node_exporter:
    image: prom/node-exporter:latest
    container_name: node-exporter
    restart: unless-stopped
    ports:
      - "9100:9100"
```
Start the container:
```bash
docker-compose up -d
```

### 2️⃣ **Deploy Prometheus (VM1)**
```bash
mkdir prometheus && cd prometheus
nano prometheus.yml
```
Paste the following:
```yaml
global:
  scrape_interval: 15s

scrape_configs:
  - job_name: 'prometheus'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
  - job_name: 'node_exporter'
    static_configs:
      - targets: ['<VM2_IP>:9100']
```
Run Prometheus:
```bash
docker run -d \
  --name prometheus \
  -p 9090:9090 \
  -v $(pwd)/prometheus.yml:/etc/prometheus/prometheus.yml \
  prom/prometheus
```

### 3️⃣ **Deploy Grafana (VM1)**
```bash
docker run -d \
  --name grafana \
  -p 3000:3000 \
  -v grafana_data:/var/lib/grafana \
  grafana/grafana
```
Access Grafana at `http://<VM1_IP>:3000` (Default login: `admin/admin`).

### 4️⃣ **Add Prometheus as Data Source in Grafana**
- Go to **Configuration** > **Data Sources**.
- Click **Add Data Source**, select **Prometheus**.
- Set URL to `http://<VM1_IP>:9090`, then **Save & Test**.

### 5️⃣ **Import a Grafana Dashboard**
- Navigate to **Dashboards** > **Import**.
- Use dashboard ID `1860` for Node Exporter.

## 🚀 Next Steps
- **Deploy Infrastructure using Terraform** 🌍  
- **Integrate CI/CD with Jenkins** 🔄  

## 🤝 Contributors
- **Mohamed Elweza**


