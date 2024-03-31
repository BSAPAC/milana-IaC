resource "null_resource" "azure_cli" {
  provisioner "local-exec" {
    command = "az account set --subscription ${var.az_subscription}"
  }
  provisioner "local-exec" {
    command = "set KUBECONFIG=./kubeconfig && az aks get-credentials --resource-group ${var.resource_group_name} --name ${var.azurerm_kubernetes_cluster} --overwrite-existing"
  }
  provisioner "local-exec" {
    command = "az aks get-credentials --resource-group ${var.resource_group_name} --name ${var.azurerm_kubernetes_cluster} --overwrite-existing"
  }
  depends_on = [azurerm_kubernetes_cluster.aks_cluster]
}