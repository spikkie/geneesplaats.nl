#!/usr/bin/env bash
set -x
set -e

gcloud auth activate-service-account --key-file=/home/$USER/spikkie-service-account.json
