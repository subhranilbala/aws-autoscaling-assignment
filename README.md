# AWS Auto Scaling and Security Implementation

## 📌 Objective

Set up a virtual machine in AWS, implement auto-scaling based on workload, and configure security measures including IAM roles and firewall rules.

------------------------------------------------------------------------

## 🧱 Architecture Overview

This project demonstrates a scalable and secure cloud architecture using AWS services:

-   EC2 instance for hosting a web server
-   Auto Scaling Group (ASG) for dynamic scaling
-   Launch Template for instance configuration
-   Application Load Balancer
-   IAM role for secure access control
-   Security Groups acting as firewall

------------------------------------------------------------------------

## ⚙️ Implementation Steps

### 1. EC2 Instance Creation

-   Launched an EC2 instance using Amazon Linux 2 AMI
-   Selected instance type: `t3.micro`
-   Configured key pair (.pem) for SSH access
-   Enabled inbound rules:
    -   SSH (Port 22) restricted to my IP
    -   HTTP (Port 80) open to all

------------------------------------------------------------------------

### 2. Web Server Setup

Installed Apache HTTP server on EC2:

``` bash
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
```

Created a sample webpage:

``` bash
echo "Hello from Auto Scaling Instance" > /var/www/html/index.html
```

------------------------------------------------------------------------

### 3. AMI Creation

-   Created a custom AMI from configured EC2 instance
-   This AMI is used as a template for auto-scaling instances

------------------------------------------------------------------------

### 4. Launch Template

-   Created a launch template using:
    -   Custom AMI
    -   Instance type: `t3.micro`
    -   Existing key pair
    -   Security group with HTTP + SSH access

------------------------------------------------------------------------

### 5. Auto Scaling Group (ASG)

-   Created ASG using the launch template
-   Configured:
    -   Minimum instances: 1
    -   Desired instances: 1
    -   Maximum instances: 3
-   Selected multiple subnets for high availability

------------------------------------------------------------------------

### 6. Auto Scaling Policy

Configured Target Tracking Scaling Policy: - Metric: Average CPU
Utilization - Target: 50%

Scaling behavior: - CPU \> 50% → new instance launched - CPU \< 50% →
instance terminated

------------------------------------------------------------------------

### 7. Load Balancer

-   Created Application Load Balancer
-   Connected ASG to distribute traffic evenly across instances

------------------------------------------------------------------------

## 🔐 Security Configuration

### IAM Role

-   Created IAM role for EC2
-   Attached policy: `AmazonS3ReadOnlyAccess`
-   Assigned role to EC2 instances via launch template

Purpose: - Avoid storing credentials inside instances - Provide
controlled access to AWS services

------------------------------------------------------------------------

### Security Group (Firewall Rules)

  Type   Port   Source
  ------ ------ ------------
  SSH    22     My IP only
  HTTP   80     0.0.0.0/0

Purpose: - Restrict SSH access - Allow public web access

------------------------------------------------------------------------

## 🧪 Testing Auto Scaling

To simulate high CPU load:

``` bash
yes > /dev/null &
```

Observed behavior: - CPU utilization increased - Auto Scaling Group
launched additional instance

------------------------------------------------------------------------

## 📁 Repository Contents

-   `setup.sh` → Script to install and configure web server
-   `README.md` → Project documentation
-   `architecture.png` → Architecture diagram

------------------------------------------------------------------------

## ▶️ Demo Video

The demo video includes: - EC2 instance setup - Web server access via
browser - Auto Scaling configuration - Live scaling demonstration -
Security configurations (IAM + Security Groups)

------------------------------------------------------------------------

## ✅ Conclusion

This project successfully demonstrates: - Deployment of a virtual
machine in AWS - Implementation of auto-scaling based on CPU
utilization - Secure configuration using IAM roles and firewall rules

The system is scalable, fault-tolerant, and follows cloud security best
practices.
