variable "cluster_name" {
  type        = string
  description = "The name of the cluster."
  default     = "web-app-cluster"
}

variable "cluster_config_path" {
  type        = string
  description = "Cluster's kubeconfig location"
  default     = "~/.kube/config"
}

variable "namespaces" {
  type        = list(string)
  description = "This is a list of namespaces in the cluster"
  default     = ["test", "prod"]
}