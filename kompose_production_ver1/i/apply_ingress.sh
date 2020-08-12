#!/usr/bin/env bash 
set -x

kubectl apply -f letsencrypt-clusterissuer-prod.nginx.yaml  -n ingress-nginx
kubectl apply -f react-ingress.yaml -n ingress-nginx
