# Terraform Code for Azure Kubernetes Cluster

This repository contains Terraform scripts to provision an Azure Resource Group, an Azure Kubernetes Service (AKS) cluster, an Azure Container Registry (ACR), and set up an Ingress controller and Grafana for monitoring in the AKS cluster.

## Prerequisites

Before you begin, ensure you have the following prerequisites in place:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- Azure CLI installed and authenticated with your subscription.
- kubectl and helm for managing kubernetesb resources

### Creating an Azure Service Principal

Before using this Terraform project to provision Azure resources, you'll need to create an Azure Service Principal with the necessary permissions. Here's how you can create a service principal:

1. Open the Azure CLI or Azure Cloud Shell.

2. Run the following command, replacing `<service_principal_name>` with a name for your service principal and `<subscription_id>` with your Azure subscription ID:

```bash
az ad sp create-for-rbac --name <service_principal_name> --role Contributor --scopes /subscriptions/<subscription_id>
```

## Usage

1. Clone this repository to your local machine.

```bash
git clone https://github.com/BSAPAC/milana-IaC.git
cd milana-iac
```

2. Customize variables as per requirements in tfvars file.

```bash
# terraform.tfvars
resource_group_name = "my-rg"
location = "East US"
azurerm_kubernetes_cluster = "my-aks-cluster"
azure_acr = "myacr"
# ... other variables

```
3. Initialize Terraform and download the necessary providers.

```bash
terraform init
```

3. Plan and apply the Terraform configuration..

```bash
terraform plan
terraform apply
```

4. Access the AKS cluster

```bash
az aks get-credentials --resource-group your-rg-name --name your-aks-cluster-name
```

## Testing 

- After all components running
- Add your test domain in infra-test/ingress-rule.yaml file 
- Add dns entry with your domain and loadbalancer ip of ingress 
- And apply this files 

```bash
kubectl apply -f infra-test/manifest.yaml
kubectl apply -f infra-test/ingress-rule.yaml
```

## Functionslities 

1. How to add nodepool 

copy  

```bash
b2sv2 = {
    to 
  }
```
from tfvar & change values like 

```bash
  d2sv5 = {
    name                = "d2sv5"  # your node pool name will be "stdd2sv5"
    vm_size             = "Standard_D2s_v5"  # add vm size from azure 
    node_count          = 0      # initial node count 
    max_count           = 2      # max node count 
    min_count           = 0      # min node count 
    enable_auto_scaling = "true" # to enable node autoscaling
    zones               = []
    mode                = "User" 
    os_disk_size_gb     = 128
    os_disk_type        = "Managed"
    os_type             = "Linux"

    nodepool_label = {
      "d2sv5" = "true"
    }
    tags = {
      "created_by" : "your name"
    }
  }

```

2. To access grafana 

- copy dns name from terraform.tfvars and open in browser with credentials 

```bash
https://your-grafana-domain

user: admin
password: prom-operator
```

3. To access prometheus

- copy dns name from terraform.tfvars and open in browser with credentials 
```bash
https://your-prometheus-dns
```