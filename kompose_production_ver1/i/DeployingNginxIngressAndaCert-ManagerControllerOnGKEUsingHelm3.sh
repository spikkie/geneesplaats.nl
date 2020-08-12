#!/usr/bin/env bash
set -x

echo from https://medium.com/bluekiri/deploy-a-nginx-ingress-and-a-certitificate-manager-controller-on-gke-using-helm-3-8e2802b979ec

if [ !  -f /usr/local/bin/helm ]; then
echo install Helm

#Let’s start with Helm. Helm (https://helm.sh) is a package manager for Kubernetes. The three main concepts in Helm are:
#    Chart: is a Helm package that contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster.
#    Repository: where the charts can be collected and shared.
#    Release: is an instance of a chart running in a Kubernetes cluster.

#https://helm.sh/docs/intro/install/
#from script
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
else
  helm version
fi

echo setup a repository
helm repo add stable https://kubernetes-charts.storage.googleapis.com/


#Next move on to the next phase, setup the Nginx Ingress Controller. Our first step will be the creation of the Nginx’s namespace:
kubectl create ns ingress-nginx

helm install nginx stable/nginx-ingress --namespace ingress-nginx  --set rbac.create=true --set controller.publishService.enabled=true --set controller.service.loadBalancerIP=34.91.131.116

kubectl --namespace ingress-nginx get services -o wide 

echo  install cert-manager
./i/install-cert-manager.sh

kubectl create namespace cert-manager

helm repo add jetstack https://charts.jetstack.io
helm repo update
kubectl get pods -n cert-manager





