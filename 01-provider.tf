terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.67.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.21.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.10.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.40.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.7.0"
    }
    template = {
      source  = "gxben/template"
      version = "= 2.2.0-m1"
    }
  }
}
provider "azurerm" {
  subscription_id = var.az_subscription
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  features {
  }
}
provider "kubernetes" {
  config_path = "./kubeconfig"
}
provider "helm" {
  kubernetes {
    config_path = "./kubeconfig"
  }
}
provider "null" {
}
resource "random_pet" "aksrandom" {}

