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

