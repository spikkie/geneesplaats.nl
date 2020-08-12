#!/usr/bin/env bash
set -x

gcloud config configurations list
echo gcloud compute addresses create geneesplaats-nl-static-ip --global

