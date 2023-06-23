# Simple web app

## Content

    Simple web application deployed on a local Kubernetes cluster using Kind. Helm is used to package and deploy the application using a Helm chart. Nginx serves the static HTML page, which includes dynamic content based on the Kubernetes namespace. Terraform is used to manage the infrastructure and deploy the Kubernetes resources and Helm release.
    This application could be deployed with terraform to a local cluster created with kind. 

## Description

    The application is a basic web application powered by Nginx. It serves a static HTML page that displays information about the Kubernetes namespace in which it is deployed. The HTML page is dynamically generated using template variables.

    For this we have some requirements as 
    - terraform
    - helm
    - kind [requires docker as daemon set]
    - kubectl
    - [optional] k9s

Note: This is a simplified overview, and additional tools and configurations may be required depending on your specific setup

## How to use

***
### With terraform


Move inside this repository and simply run these commands:

1. Deploy terraform code:

```shell
terraform init
terraform apply -auto-approve
```

2. Redirection port for our localhost:

```shell
kubectl --namespace default port-forward service/webapp-ngix-service 8888:80
```

This line will showup when deploy with helm.

3. See the result in [http:localhost//localhost:8888/](http://localhost:8888/)
4. Further configurations can be done [here](tf_kind/variables.tf) where the variables are set with default values.

***
### With helm

Move inside this [folder](./web-app/) and simply run these commands:

1. install helm charts:

```bash
helm install <name> <path> 
```

2. Redirection port for our localhost:

```bash
kubectl --namespace default port-forward service/webapp-ngix-service 8888:80
```

3. See the result in [http:localhost//localhost:8888/](http://localhost:8888/)

4. Further configurations can be done [here](./web-app/values.yaml) where the variables are set with default values.

***
## Usefull links

    kind release --> https://github.com/kubernetes-sigs/kind/releases

***
## Usefull commands

```bash
# kubectl, K as local alias for kubectl 
kubectl get deployment
k get services
k get configmap
k get nodes
k --namespace <namespace> port-forward service/<appName>-service 8888:80 
k create namespace <name>

# kind
kind create cluster --name <name>     
kind delete cluster --name <name>
kind get clusters
# to load a local docker image to our cluster
kind load docker-image <image>:<tag> --name <cluster-name>

# Helm
helm lint
helm template <path>
helm install --dry-run <name> <path>
helm install <name> <path>
helm upgrade <name> <path>
helm list
helm rollback <name>
helm rollback <name> <revision-number>
helm uninstall <name>
```
***
### Notes

This is an example application. May or may not work properly.

The terraform deployment may need some extra steps to open traffic to you kubernetes cluster not described here.
