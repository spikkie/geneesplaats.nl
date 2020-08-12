#!/usr/bin/env bash 
set -x

export IC_IP=34.90.93.255
export IC_HTTPS_PORT=80
export IC_HTTP_PORT=80

kubectl create namespace nginx-ingress
kubectl create secret docker-registry regcred-nginx-ingress --docker-server=https://index.docker.io/v1/   --docker-username=spikkie --docker-password=Bessabessa16\!\! --docker-email=spikkie@gmail.com --namespace=nginx-ingress
kubectl apply -f $(ls  -p *.yaml  | grep -v / | tr '\n' ','  | sed 's/.$//')

