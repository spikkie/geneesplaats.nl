#!/usr/bin/env bash
set -x

echo delete cluster

jx delete gke \
    --project-id=geneesplaats-nl-jx \
    --cluster-name=geneesplaat-nl-jx \
    --region=europe-west4-a 

