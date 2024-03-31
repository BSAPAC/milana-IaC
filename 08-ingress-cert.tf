resource "null_resource" "crdapply" {
  provisioner "local-exec" {
    command = "kubectl apply -f ./cert-manager/cert-manager-crds.yaml"
  }
  depends_on = [null_resource.namespaces]
}
resource "helm_release" "certmanager" {
  name       = "certmanager"
  chart      = "./cert-manager/cert-manager"
  namespace  = "ingress"
  timeout    = 600
  wait       = true
  depends_on = [null_resource.crdapply]
}
resource "null_resource" "cert-issuer" {
  provisioner "local-exec" {
    command = "kubectl apply -f ./cert-manager/cert-issuer.yaml -n ingress"
  }
  depends_on = [helm_release.certmanager]
}
resource "helm_release" "ingress-nginx" {
  name       = "ingress"
  chart      = "./ingress/ingress-nginx"
  wait       = true
  namespace  = "ingress"
  timeout    = 600
  depends_on = [null_resource.crdapply]
}