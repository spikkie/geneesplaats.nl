#!/usr/bin/env bash

echo install cert-manager on Kubernetes
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.15.1/cert-manager.yaml

