#!/usr/bin/env bash
set -e
set -x

kubectl config set-context --current --namespace=ingress-nginx

echo '---------------------------------------------------------------------'
kubectl describe all 
echo '---------------------------------------------------------------------'
kubectl describe pvc
echo '---------------------------------------------------------------------'
kubectl describe pv

echo '---------------------------------------------------------------------'
kubectl describe Certificate 
echo '---------------------------------------------------------------------'
kubectl describe CertificateRequest 
echo '---------------------------------------------------------------------'
kubectl describe Order 
echo '---------------------------------------------------------------------'
kubectl describe Challenge 
echo '---------------------------------------------------------------------'

kubectl describe issuer 
echo '---------------------------------------------------------------------'
#kubectl describe event

kubectl describe secret
echo '---------------------------------------------------------------------'
kubectl describe ing
echo '---------------------------------------------------------------------'

