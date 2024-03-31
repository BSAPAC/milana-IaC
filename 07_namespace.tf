resource "null_resource" "namespaces" {
  for_each = toset(var.namespaces)
  provisioner "local-exec" {
    command = "kubectl create ns ${each.value}"
  }
  depends_on = [null_resource.azure_cli]
}