#/usr/bin/env bash 
set -x
set -e

Environments=('development' 'production' 'production_test' 'development_test')
# todo
# stash 

if [[ $# < 1 ]]; then
    echo Error: 1 parameter required identifying the environment
    echo One of these values:
    echo ${Environments[@]}
    exit
fi

ENVIRONMENT=$1

if [[ ! " ${Environments[@]} " =~ " ${ENVIRONMENT} " ]]; then
    echo Error: 1 parameter has to be equal to one of these values: 
    echo     ${Environments[@]}
    exit
fi


if [[ $# > 1 ]]; then
    RELEASE_VERSION=$2
fi

if [[ -z $RELEASE_VERSION ]];then
    RELEASE_VERSION=latest
fi

echo Generating docker_env for $ENVIRONMENT environment -- release $RELEASE_VERSION



#.docker-env-base-${ENVIRONMENT} will only be generated once
if [[ ! -f .docker-env-base-${ENVIRONMENT} ]];then
    if [[ "${ENVIRONMENT}" = 'production' ]];then
        DEBUG=1
    elif [[ "${ENVIRONMENT}" = 'development' ]];then
        DEBUG=1
    elif [[ "${ENVIRONMENT}" = 'development_test' ]];then
        DEBUG=1
    elif [[ "${ENVIRONMENT}" = 'production_test' ]];then
        DEBUG=1
    else
        >&2 echo "Error: ENVIRONMENT ${ENVIRONMENT} not correct"
        exit 1
    fi


    PG_DB=${ENVIRONMENT}_geneesplaats_nl
    PG_USER=${ENVIRONMENT}_geneesplaats_nl_user
    PG_PASSWORD=`head -c 18 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 12`
    PG_SERVICE_NAME=postgres
    DOCKER_ACCESS_TOKEN=85e012d5-22c2-46b6-ada4-472616f692bf

    echo "POSTGRES_DB=$PG_DB
POSTGRES_USER=$PG_USER
POSTGRES_PASSWORD=$PG_PASSWORD
DATABASE_URL=postgres://$PG_USER:$PG_PASSWORD@$PG_SERVICE_NAME:5432/$PG_DB
SECRET_KEY=`head -c 75 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 50`
DEBUG=$DEBUG
ENVIRONMENT=$ENVIRONMENT"> .docker-env-base-${ENVIRONMENT}
fi

if [[ ! -f .docker-env-base-${ENVIRONMENT} ]];then
    echo Error: Strange file .docker-env-base-${ENVIRONMENT} does not exist
    exit 1
fi

cat .docker-env-base-${ENVIRONMENT} > .env

# Docker Images
echo "POSTGRES_GENEESPLAATS_NL_IMAGE=postgres
DJANGO_GENEESPLAATS_NL_IMAGE=spikkie/django_geneesplaats_nl_${ENVIRONMENT}
NGINX_GENEESPLAATS_NL_IMAGE=spikkie/nginx_geneesplaats_nl_${ENVIRONMENT} 
REACT_GENEESPLAATS_NL_IMAGE=spikkie/react_geneesplaats_nl_${ENVIRONMENT}" >> .env

# Docker Image Versions
echo "POSTGRES_GENEESPLAATS_NL_VERSION=latest
DJANGO_GENEESPLAATS_NL_VERSION=${RELEASE_VERSION}
NGINX_GENEESPLAATS_NL_VERSION=${RELEASE_VERSION} 
REACT_GENEESPLAATS_NL_VERSION=${RELEASE_VERSION}" >> .env

echo Generated file .env

# generate .env
# ENGINE_KEY=YOUR_APLLO_ENGINE_API_KEY
# NODE_ENV=development
# JWT_SECRET=YOUR_JWT_SECRET
# AWS_ACCESS_KEY_ID=YOUR_AWS_KEY_ID
# AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_ACCESS_KEY
# username=devuser
# password=Test1234%
# database=
# host=192.168.2.101

