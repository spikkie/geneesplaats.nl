#!/usr/bin/env bash
set -x

echo install cert-manager on Kubernetes via Helm 3
kubectl create namespace cert-manager
helm repo update

helm install \
  my-cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v0.15.2 \
  # --set installCRDs=true


