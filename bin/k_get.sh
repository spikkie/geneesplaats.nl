#!/usr/bin/env bash
set -e
set -x

kubectl config set-context --current --namespace=ingress-nginx

echo ---------------------------------------------
kubectl get all -A
echo ---------------------------------------------
kubectl get pvc -A
echo ---------------------------------------------
kubectl get pv -A

echo ---------------------------------------------
kubectl get Certificate  -A
echo ---------------------------------------------
kubectl get CertificateRequest  -A
echo ---------------------------------------------
kubectl get Order  -A
echo ---------------------------------------------
kubectl get Challenge -A 
echo ---------------------------------------------

kubectl get issuer  -A
echo ---------------------------------------------
#kubectl get event

kubectl get secret -A
echo ---------------------------------------------
kubectl get ing -A
echo ---------------------------------------------

echo ---------------------------------------------
echo ConfigMap
kubectl get configmap -A

