resource "helm_release" "prom-grafana" {
  name       = "pga"
  chart      = "./monitor/kube-prometheus-stack"
  wait       = true
  timeout    = 600
  namespace  = "monitoring"
  depends_on = [null_resource.namespaces]
}
resource "helm_release" "loki" {
  name       = "loki"
  chart      = "./monitor/loki-stack"
  wait       = true
  timeout    = 600
  namespace  = "monitoring"
  depends_on = [null_resource.namespaces]
}
resource "null_resource" "grafana-ingress" {
  provisioner "local-exec" {
    command = "kubectl apply -f ./monitor/grafana-rule.yaml"
  }
  depends_on = [helm_release.prom-grafana]
}
resource "null_resource" "prometheus-ingress" {
  provisioner "local-exec" {
    command = "kubectl apply -f ./monitor/prometheus-rule.yaml"
  }
  depends_on = [helm_release.prom-grafana]
}
