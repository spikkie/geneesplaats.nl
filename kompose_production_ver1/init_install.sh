#!/usr/bin/env bash
set -x

./login.sh

echo initial installation
kubectl create namespace ingress-nginx

#install helm 3
./i/install_helm.sh

echo install cert manager
./i/install-kube-ctl-cert-man.sh
./i/install-cert-manager.sh

sleep 20
echo testing
./i/test-cert-manager.sh

#manuall install controller 
#set loadBalancerIP: 34.90.173.174
./i/install-nginx-ingress-controller.from.digitalocean.sh

./i/apply_services.sh
./i/apply_ingress.sh

echo ./i/init_database.sh

