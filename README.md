# 🚀 Azure Platform IaC (Terraform)

This repository provides a modular, scalable, and production-ready Infrastructure as Code (IaC) setup for provisioning Azure resources using Terraform.

It follows best practices with reusable modules, environment-based configurations, and dependency management.

---

## 📌 Overview

The infrastructure is designed using a **modular approach**, where each Azure resource is defined as a reusable Terraform module.

The solution supports:
- Multi-resource provisioning  
- Environment-based deployments (dev, prod)  
- Dependency handling between resources  
- Scalable and maintainable infrastructure  

---

## 📁 Project Structure

```
azure-platform-iac/
│
├── Environments/
│   └── dev/
│       ├── main.tf
│       ├── provider.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       ├── locals.tf
│       └── data.tf
│
├── modules/
│   ├── azurerm_resource_group/
│   ├── azurerm_virtual_network/
│   ├── azurerm_subnet/
│   ├── azurerm_nsg/
│   ├── azurerm_nsg_connection/
│   ├── azurerm_public_ip/
│   ├── azurerm_nic/
│   ├── azurerm_lb/
│   ├── azurerm_vmss/
│   ├── azurerm_azure_bastion/
│   ├── azurerm_appgtw/
│   └── azurerm_key_vault/
│
└── README.md
```

---

## 🧱 Infrastructure Components

This setup provisions the following Azure resources:

- Resource Groups  
- Virtual Network (VNet)  
- Subnets  
- Network Security Groups (NSG)  
- NSG Associations  
- Public IPs  
- Network Interfaces (NIC)  
- Load Balancer  
- Virtual Machine Scale Set (VMSS)  
- Azure Bastion  
- Application Gateway  
- Key Vault  

---

## 🔗 Module-Based Architecture

Each resource is created using Terraform modules:

```hcl
module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}
```

### ✅ Key Benefits:
- Reusability  
- Clean code structure  
- Easy maintenance  
- Scalable architecture  

---

## ⚙️ Dependency Management

Terraform `depends_on` is used to ensure correct resource creation order:

- VNet depends on Resource Group  
- Subnets depend on VNet  
- NSG Associations depend on Subnets and NSGs  

This ensures smooth and reliable infrastructure deployment.

---

## 🌍 Environment-Based Deployment

Infrastructure is organized by environment:

```
Environments/dev/
```

You can extend it for:
- `dev`
- `test`
- `prod`

---

## 🚀 How to Use

### 1️⃣ Initialize Terraform
```bash
terraform init
```

### 2️⃣ Validate Configuration
```bash
terraform validate
```

### 3️⃣ Plan Deployment
```bash
terraform plan
```

### 4️⃣ Apply Changes
```bash
terraform apply
```

---

## 💡 Key Features

- Modular Terraform design  
- Environment-specific configuration  
- Scalable Azure infrastructure  
- Dependency-aware deployment  
- Production-ready structure  

---

## 🎯 Use Case

- Enterprise-level Azure infrastructure provisioning  
- DevOps automation using Terraform  
- Multi-resource deployment with modular architecture  
- Real-world production setup  

---

## 🚀 Future Enhancements

- Remote backend (Azure Storage)  
- CI/CD pipeline integration  
- State locking and versioning  
- Monitoring and logging integration  

---

🔥 *Enterprise-grade Azure infrastructure using Terraform modules*
