#!/usr/bin/env bash
set -x

echo Install NGINX Ingress Controller 

#echo from https://kubernetes.github.io/ingress-nginx/deploy/#gce-gke

kubectl create clusterrolebinding cluster-admin-binding --clusterrole cluster-admin --user $(gcloud config get-value account)

#For private clusters, you will need to either add an additional firewall rule that allows master nodes access port 8443/tcp on worker nodes, or change the existing rule that allows access to ports 80/tcp, 443/tcp and 10254/tcp to also allow access to port 8443/tcp.
#See the GKE documentation on adding rules and the Kubernetes issue for more detail.


#kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v0.34.1/deploy/static/provider/cloud/deploy.yaml
kubectl apply -f ./i/deploy-install-nginx-ingress-controller.from.digitalocean.yaml 

kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=120s
