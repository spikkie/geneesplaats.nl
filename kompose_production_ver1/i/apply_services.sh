#!/usr/bin/env bash 
set -x

# export IC_IP=http://34.96.92.48
#export IC_HTTPS_PORT=80
#export IC_HTTP_PORT=80

kubectl create ns ingress-nginx

kubectl create secret docker-registry regcred-nginx-ingress --docker-server=https://index.docker.io/v1/   --docker-username=spikkie --docker-password=Bessabessa16\!\! --docker-email=spikkie@gmail.com 

#kubectl apply -f $(ls  -p *.yaml  | grep -v / | tr '\n' ','  | sed 's/.$//')  -n ingress-nginx
kubectl apply -f postgres-backup-prod-persistentvolumeclaim.yaml -n ingress-nginx
kubectl apply -f postgres-data-prod-persistentvolumeclaim.yaml -n ingress-nginx
kubectl apply -f postgres-deployment.yaml -n ingress-nginx
kubectl apply -f react-deployment.yaml -n ingress-nginx
kubectl apply -f postgres-service.yaml -n ingress-nginx
kubectl apply -f react-service.yaml -n ingress-nginx


#kubectl apply -f letsencrypt-clusterissuer-prod.nginx.yaml  -n ingress-nginx
#kubectl apply -f react-ingress.yaml ingress-nginx
