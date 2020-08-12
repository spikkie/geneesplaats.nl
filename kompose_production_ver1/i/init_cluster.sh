#!/usr/bin/env bash
set -x

gcloud config configurations list
echo gcloud config configurations activate cloudshell-32705
gcloud container clusters create geneesplaats-nl-cluster-1  --zone europe-west4-a --num-nodes=2 --cluster-version=1.16.13-gke.1  --machine-type "n1-standard-1" --num-nodes "2" --enable-autoscaling --min-nodes "2" --max-nodes "3"

#from https://medium.com/bluekiri/deploy-a-nginx-ingress-and-a-certitificate-manager-controller-on-gke-using-helm-3-8e2802b979ec
#gcloud container clusters create gke-helm3 --project "poc-helm3" --zone "europe-west1-b" --cluster-version "1.14.8-gke.12" --machine-type "n1-standard-1" --num-nodes "1" --enable-autoscaling --min-nodes "1" --max-nodes "3"


#download the cluster credentials to our environment executing:
#gcloud container clusters get-credentials  geneesplaats-nl-cluster-1  --zone europe-west4-a
#Fetching cluster endpoint and auth data.
#kubeconfig entry generated for geneesplaats-nl-cluster-1.

