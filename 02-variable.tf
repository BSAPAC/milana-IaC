# Azure Resource Group Name
variable "resource_group_name" {
  type = string
}
# Azure Region Location
variable "location" {
  description = "Azure Region where all these resources will be provisioned"
  type        = string
}
variable "aks_vnet_name" {
  type = string
}
variable "aks_vnet_cidr" {
  type = list(string)
}
variable "aks_subnet_name" {
  type = string
}
variable "aks_subnet_cidr" {
  type = list(string)
}
# Azure Cluster Name 
variable "azurerm_kubernetes_cluster" {
  type = string
}
# Azure Container Registry 
variable "azure_acr" {
  type = string
}
variable "az_subscription" {
  type = string
}
variable "client_id" {
  type = string
}
variable "client_secret" {
  type = string
}
variable "tenant_id" {
  type = string
}
variable "orchestrator_version" {
  description = "This variable defines aks version"
  type        = string
}
variable "availability_zones" {
  description = "This variable defines the Environment"
  type        = list(string)
}
variable "created_by" {
  type = string
}
variable "grafana-domain" {
  type = string
}
variable "prometheus-domain" {
  type = string
}
variable "sys_pool_size" {
  type = string
}
variable "node_pool" {
  description = "This variable defines the Environment"
  type        = map(any)
}
variable "namespaces" {
  description = "This is list of namespaces"
  type        = list(string)
}