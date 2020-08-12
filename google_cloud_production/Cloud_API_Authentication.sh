#!/usr/bin/env bash
set -x

echo For authentication, we recommend using a service account: a Google account that is associated with your GCP project, 
echo from: https://cloud.google.com/docs/authentication/getting-started

gcloud iam service-accounts list

gcloud projects list

gcloud projects add-iam-policy-binding stoked-axle-267521 --member "serviceAccount:spikkie-service-account@stoked-axle-267521.iam.gserviceaccount.com" --role "roles/owner"

gcloud iam service-accounts keys create spikkie-service-account--stoked-axle-267521.iam.gserviceaccount.json --iam-account spikkie-service-account@stoked-axle-267521.iam.gserviceaccount.com

