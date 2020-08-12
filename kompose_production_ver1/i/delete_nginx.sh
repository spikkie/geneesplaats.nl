#!/usr/bin/env bash
set -x

cd git/kubernetes-ingress/deployments

kubectl delete -f common/ns-and-sa.yaml
kubectl delete -f rbac/rbac.yaml
kubectl delete -f rbac/ap-rbac.yaml
kubectl delete -f common/default-server-secret.yaml
kubectl delete -f common/nginx-config.yaml
kubectl delete -f common/vs-definition.yaml
kubectl delete -f common/vsr-definition.yaml
kubectl delete -f common/ts-definition.yaml
kubectl delete -f common/policy-definition.yaml
kubectl delete -f common/global-configuration.yaml
kubectl delete -f deployment/nginx-ingress.yaml
kubectl delete -f nginx-config.yaml


##    Delete the nginx-ingress namespace to uninstall the Ingress controller along with all the auxiliary resources that were created:
#
kubectl delete namespace nginx-ingress
#
#    Delete the ClusterRole and ClusterRoleBinding created in that step:
#
kubectl delete clusterrole nginx-ingress
kubectl delete clusterrolebinding nginx-ingress

