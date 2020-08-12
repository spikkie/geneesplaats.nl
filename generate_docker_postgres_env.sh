#/usr/bin/env bash 
set -x
set -e

. ./generate_docker_env_input.sh

#.docker-env-base-postgres-${ENVIRONMENT} will only be generated once
if [[ ! -f .docker-env-base-postgres-${ENVIRONMENT} ]];then
    if [[ "${ENVIRONMENT}" = 'production' ]];then
        DEBUG=1
        NODE_ENV=production
    elif [[ "${ENVIRONMENT}" = 'development' ]];then
        DEBUG=1
        NODE_ENV=development
    elif [[ "${ENVIRONMENT}" = 'development_test' ]];then
        DEBUG=1
        NODE_ENV=development_test
    elif [[ "${ENVIRONMENT}" = 'production_test' ]];then
        DEBUG=1
        NODE_ENV=production_test
    else
        >&2 echo "Error: ENVIRONMENT ${ENVIRONMENT} not correct"
        exit 1
    fi


    PG_DB=${ENVIRONMENT}_geneesplaats_nl
    PG_USER=${ENVIRONMENT}_geneesplaats_nl_user
    PG_PASSWORD=`head -c 18 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 12`
    PG_SERVICE_NAME=postgres

    echo "POSTGRES_DB=$PG_DB
POSTGRES_USER=$PG_USER
POSTGRES_PASSWORD=$PG_PASSWORD
DATABASE_URL=postgres://$PG_USER:$PG_PASSWORD@$PG_SERVICE_NAME:5432/$PG_DB
SECRET_KEY=`head -c 75 /dev/urandom | base64 | tr -dc 'a-zA-Z0-9' | head -c 50`
DEBUG=$DEBUG
ENVIRONMENT=$ENVIRONMENT
NODE_ENV=$NODE_ENV" > .docker-env-base-postgres-${ENVIRONMENT}
fi

if [[ ! -f .docker-env-base-postgres-${ENVIRONMENT} ]];then
    echo Error: Strange file .docker-env-base-postgres-${ENVIRONMENT} does not exist
    exit 1
else
    cat .docker-env-base-postgres-${ENVIRONMENT} > .postgres_env
fi

POSTGRES_REPOSITORY=postgres_geneesplaats_nl_${ENVIRONMENT}
# Docker Images
# Docker Image Versions
echo "DOCKERID=${DOCKERID}
POSTGRES_GENEESPLAATS_NL_IMAGE=postgres:12.1-alpine
POSTGRES_REPOSITORY=${POSTGRES_REPOSITORY}
POSTGRES_GENEESPLAATS_NL_VERSION=latest" >> .postgres_env

cat .postgres_env >> .env
echo Generated file .postgres_env
