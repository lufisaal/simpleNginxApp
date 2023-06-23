
resource "kind_cluster" "default" {
  name            = var.cluster_name
  kubeconfig_path = pathexpand(var.cluster_config_path)
  wait_for_ready  = true

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }
    node {
      role = "worker"
    }
    node {
      role = "worker"
    }
  }
}

resource "kubernetes_namespace" "web-cluster-namespace" {
  for_each = toset(var.namespaces)
  metadata {
    name = each.value
  }
}

resource "helm_release" "install-web-app" {
  for_each   = var.namespaces

  name      = "kind-web-app-cluster"
  chart     = "./web-app"
  namespace = var.namespaces
  set {
    name  = "replicas"
    value = "1"
  }
  set {
    name  = "image.repository"
    value = "docker.io/library/nginx"
  }
  set {
    name  = "image.tag"
    value = "latest"
  }
}

