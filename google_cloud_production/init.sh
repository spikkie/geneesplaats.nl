#!/usr/bin/env bash
set -x

gcloud config configurations list
echo gcloud config configurations activate cloudshell-32705
gcloud container clusters create geneesplaats-nl-cluster-1 --zone europe-west4-a --num-nodes=2


#delete a cluster
gcloud container clusters delete  geneesplaats-nl-cluster-1

#get credentiels
gcloud container clusters get-credentials geneesplaats-nl-cluster-1 --zone europe-west4-a --project stoked-axle-267521

