#!/usr/bin/env bash
set -x

echo create a new cluster

gcloud config set project geneesplaats-nl-jx

jx create cluster gke \
    --cluster-name=cluster-geneesplaats-nl-jx \
    --project-id=geneesplaats-nl-jx \
    --zone=europe-west4-a \
    --machine-type=e2-standard-2 \
    --max-num-nodes=3 \
    --min-num-nodes=2 \
    --skip-login \
    --skip-installation

