#!/usr/bin/env bash 
set -x
kubectl delete -f $(ls  -p *.yaml  | grep -v / | tr '\n' ','  | sed 's/.$//')
