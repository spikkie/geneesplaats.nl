#!/usr/bin/env bash

echo uninstall cert-manager on Kubernetes
kubectl delete -f https://github.com/jetstack/cert-manager/releases/download/v0.15.1/cert-manager.yaml

