!#/usr/bin/env bash
set -x

echo initialize the database

REACT_POD=$(kubectl get pods -n ingress-nginx| grep '^react'| awk '{print $1}')
echo $REACT_POD
kubectl exec -it $REACT_POD  -c  react-geneesplaats-nl-production  -- sequelize db:migrate
