#!/usr/bin/env bash
set -x

#gcloud container clusters create geneesplaats-nl-cluster-1 --zone europe-west4-a --num-nodes=2 --cluster-version=1.16.10-gke.8 
gcloud container clusters delete geneesplaats-nl-cluster-1 --zone europe-west4-a


