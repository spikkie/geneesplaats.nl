#!/usr/bin/env bash
set -x

./login.sh

INPUT=$1
if [ -z "$INPUT" ];then
  echo input has to be defined
  exit
fi


echo $INPUT

CURRENT_VALUE=$(grep 'image: spikkie/react_geneesplaats_nl_production:' react-deployment.yaml |sed 's/.*://')
if [ -z "$CURRENT_VALUE" ];then
  echo  no value found behind image: spikkie/react_geneesplaats_nl_production: in react-deployment.yaml
  exit
fi

echo $CURRENT_VALUE

sed -i "s/$CURRENT_VALUE/$INPUT/" react-deployment.yaml

kubectl apply --recursive -f react-deployment.yaml

sleep 5

kubectl get pods

