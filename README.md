# Terraform Apache Web Server on AWS (Custom VPC)

## 📌 Project Overview
This project demonstrates how to provision a complete AWS infrastructure **from scratch** using **Terraform**.  
It deploys an **Apache Web Server** on an EC2 instance inside a **custom VPC**, following real-world cloud and DevOps best practices.

The goal of this project is to show hands-on experience with:
- Infrastructure as Code (IaC)
- AWS networking fundamentals
- Terraform resource management
- Git & GitHub workflow

---

## 🛠️ Technologies Used
- **Terraform**
- **AWS (EC2, VPC, Subnet, Internet Gateway, Route Table, Security Groups)**
- **Apache HTTP Server**
- **Git & GitHub**
- **Linux (User Data / Shell Script)**

---

## 🏗️ Architecture
- Custom VPC
- Public Subnet
- Internet Gateway
- Route Table with internet access
- EC2 instance with Apache installed using User Data
- Security Group allowing HTTP (80) and SSH (22)

---

## 📂 Project Structure
# Terraform Apache Web Server on AWS (Custom VPC)

## 📌 Project Overview
This project demonstrates how to provision a complete AWS infrastructure **from scratch** using **Terraform**.  
It deploys an **Apache Web Server** on an EC2 instance inside a **custom VPC**, following real-world cloud and DevOps best practices.

The goal of this project is to show hands-on experience with:
- Infrastructure as Code (IaC)
- AWS networking fundamentals
- Terraform resource management
- Git & GitHub workflow

---

## 🛠️ Technologies Used
- **Terraform**
- **AWS (EC2, VPC, Subnet, Internet Gateway, Route Table, Security Groups)**
- **Apache HTTP Server**
- **Git & GitHub**
- **Linux (User Data / Shell Script)**

---

## 🏗️ Architecture
- Custom VPC
- Public Subnet
- Internet Gateway
- Route Table with internet access
- EC2 instance with Apache installed using User Data
- Security Group allowing HTTP (80) and SSH (22)

---

## 📂 Project Structure
Terraform-Apache-Project/
│
├── main.tf # Core infrastructure resources
├── variables.tf # Input variable declarations
├── terraform.tfvars # Actual values for variables
├── .gitignore # Ignored Terraform files
└── README.md # Project documentation



---

## ⚙️ Prerequisites
Before running this project, make sure you have:
- AWS Account
- Terraform installed
- AWS CLI configured (`aws configure`)
- Existing EC2 key pair (public key path)

---

## 🚀 How to Run the Project

deployment_steps:
  - step: Initialize Terraform
    command: terraform init
    description: >
      Downloads required providers and initializes the Terraform working directory.

  - step: Validate Configuration
    command: terraform validate
    description: >
      Checks Terraform files for syntax and configuration errors.

  - step: Preview Infrastructure
    command: terraform plan
    description: >
      Shows an execution plan of resources that will be created, modified, or destroyed.

  - step: Apply Configuration
    command: terraform apply
    description: >
      Provisions the AWS infrastructure as defined in the Terraform files.
    note: Type "yes" when prompted to confirm resource creation.



application_output:
  - action: Retrieve EC2 Public IP
    description: >
      After successful deployment, copy the public IP address of the EC2 instance
      from the AWS Console or Terraform output.

  - action: Access Web Server
    url_format: http://<EC2_PUBLIC_IP>
    expected_result: Apache default welcome page



cleanup_steps:
  - step: Destroy Infrastructure
    command: terraform destroy
    description: >
      Deletes all AWS resources created by Terraform to avoid unnecessary charges.

