# 🛠️ AWS Infrastructure as Code (IaC) with Terraform

Welcome to the **Terraform on AWS Mastery Repository**! This repository serves as a comprehensive collection of hands-on Terraform configurations, custom modules, and end-to-end infrastructure projects. It is designed to demonstrate both foundational and advanced IaC practices on AWS.

From deploying S3-hosted static websites to building custom VPC modules and bulk-provisioning IAM users dynamically from YAML files, this repo encapsulates real-world patterns.

---

## 📂 Project Architecture & Directory Guide

The repository is organized into distinct project directories. Directories marked with a **`P`** suffix represent practice/alternative implementations for that specific topic.

### 🚀 Hands-On Projects

| Directory | Description | Key AWS Resources |
| :--- | :--- | :--- |
| [**`proj-static-website`**](file:///d:/abhim/Documents/TF-AWS/proj-static-website) | End-to-end S3 static website hosting with index/styling uploads, public block configs, and bucket policy permissions. | `aws_s3_bucket`, `aws_s3_object`, `aws_s3_bucket_policy`, `aws_s3_bucket_website_configuration` |
| [**`aws-vpc-ec2-nginx`**](file:///d:/abhim/Documents/TF-AWS/aws-vpc-ec2-nginx) / [**`aws-vpc-ec2-nginxP`**](file:///d:/abhim/Documents/TF-AWS/aws-vpc-ec2-nginxP) | Provisions a custom VPC, subnet, route table, security group, and an EC2 instance provisioned with Nginx. | `aws_vpc`, `aws_subnet`, `aws_security_group`, `aws_instance`, `aws_route_table_association` |
| [**`aws-IAM-management`**](file:///d:/abhim/Documents/TF-AWS/aws-IAM-management) / [**`aws-IAM-managementP`**](file:///d:/abhim/Documents/TF-AWS/aws-IAM-managementP) | Dynamic IAM User creation and policy attachments. Parses data dynamically from a local YAML file (`users.yaml`). | `aws_iam_user`, `aws_iam_user_login_profile`, `aws_iam_user_policy_attachment` |

### 🧩 Advanced Terraform Concept Labs

| Lab Directory | Concept Taught | Learning Highlights |
| :--- | :--- | :--- |
| [**`tf-own-module-VPC`**](file:///d:/abhim/Documents/TF-AWS/tf-own-module-VPC) | **Custom Modules** | A reusable, modularized VPC template supporting parameterized public/private subnets, routes, and internet gateways. |
| [**`tf-backend`**](file:///d:/abhim/Documents/TF-AWS/tf-backend) / [**`tf-backendp`**](file:///d:/abhim/Documents/TF-AWS/tf-backendp) | **Remote State** | Configures Terraform state storage in remote S3 buckets to enable multi-developer collaboration and secure locking. |
| [**`tf-cli-workspace`**](file:///d:/abhim/Documents/TF-AWS/tf-cli-workspace) | **CLI Workspaces** | Leverages `${terraform.workspace}` to isolate environments (e.g. `dev`, `prod`) while using the same config files. |
| [**`tf-operators-exps`**](file:///d:/abhim/Documents/TF-AWS/tf-operators-exps) / [**`tf-operators-expsP`**](file:///d:/abhim/Documents/TF-AWS/tf-operators-expsP) | **Loops & Logic** | Demonstrates `for` loops, filtering list comprehension, and map keys transformation inside local blocks. |
| [**`tf-functions`**](file:///d:/abhim/Documents/TF-AWS/tf-functions) / [**`tf-functionsP`**](file:///d:/abhim/Documents/TF-AWS/tf-functionsP) | **Built-in Functions** | Labs showcasing string transformations, collection size/contains check, lists joining, and number functions. |
| [**`tf-variables`**](file:///d:/abhim/Documents/TF-AWS/tf-variables) / [**`tf-variablesP`**](file:///d:/abhim/Documents/TF-AWS/tf-variablesP) | **Input Variables** | Working with `*.auto.tfvars`, `terraform.tfvars`, type validation, default objects, and locals merging. |
| [**`tf-data-sources`**](file:///d:/abhim/Documents/TF-AWS/tf-data-sources) / [**`tf-data-sourcesP`**](file:///d:/abhim/Documents/TF-AWS/tf-data-sourcesP) | **Data Sources** | Reading data from pre-existing AWS resources (e.g., retrieving AMI IDs or VPC attributes) without managing them. |
| [**`tf-multi-resources`**](file:///d:/abhim/Documents/TF-AWS/tf-multi-resources) / [**`tf-multi-resourcesP`**](file:///d:/abhim/Documents/TF-AWS/tf-multi-resourcesP) | **Count & For_Each** | Scalable resource allocation and naming strategies. |

### 🛠️ Core AWS Services

- [**`aws-ec2`**](file:///d:/abhim/Documents/TF-AWS/aws-ec2) / [**`aws-ec2p`**](file:///d:/abhim/Documents/TF-AWS/aws-ec2p): Quick provisioning of standalone virtual servers.
- [**`aws-s3`**](file:///d:/abhim/Documents/TF-AWS/aws-s3): Secure object storage bucket configurations paired with `random_id` suffix generators.
- [**`aws-vpc`**](file:///d:/abhim/Documents/TF-AWS/aws-vpc): Isolation layers detailing CIDR ranges, subnets, and internet routes.

---

## 🛠️ Prerequisites

Before executing any of the configurations in this repository, ensure you have:

1. **Terraform CLI** (v1.5.0+) installed on your machine.
2. **AWS CLI** installed and configured using `aws configure`.
3. An active **AWS Account** with sufficient permissions to create resources (EC2, VPC, S3, IAM, etc.).

---

## 🚀 Step-by-Step Execution Guide

To run any of the workspace projects:

### 1. Choose a Directory
Navigate to the directory you want to work in:
```bash
cd <directory-name>
```

### 2. Initialize the Workspace
Downloads the required AWS and utility providers:
```bash
terraform init
```

### 3. Generate an Execution Plan
Inspect the resources that Terraform will add, change, or destroy:
```bash
terraform plan
```

### 4. Deploy Infrastructure
Apply the configuration (type `yes` to confirm):
```bash
terraform apply
```

### 5. Tear Down Resources
When you are done experimenting, avoid incurring AWS costs by deleting all resources:
```bash
terraform destroy
```

---

## 🔒 Security & Best Practices

1. **State Isolation**: Production directories leverage S3 remote backend locks. Never commit `.tfstate` files to version control.
2. **Sensitive Variables**: Secret credentials and custom environment variables must be declared in `.tfvars` files, which are excluded from Git commits via the global [.gitignore](file:///d:/abhim/Documents/TF-AWS/.gitignore).
3. **Least Privilege**: Always execute Terraform with an IAM role that possesses only the permissions required for the target resource configuration.
