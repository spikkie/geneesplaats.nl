#/usr/bin/env bash 
set -x
set -e

. ./generate_docker_env_input.sh

#.docker-env-base-nginx-${ENVIRONMENT} will only be generated once
if [[ ! -f .docker-env-base-nginx-${ENVIRONMENT} ]];then
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

    echo "DEBUG=$DEBUG
ENVIRONMENT=$ENVIRONMENT" > .docker-env-base-nginx-${ENVIRONMENT}
fi

if [[ ! -f .docker-env-base-nginx-${ENVIRONMENT} ]];then
    echo Error: Strange file .docker-env-base-nginx-${ENVIRONMENT} does not exist
    exit 1
else
    cat .docker-env-base-nginx-${ENVIRONMENT} > .nginx_env
fi

NGINX_REPOSITORY=nginx_geneesplaats_nl_${ENVIRONMENT}
# Docker Images
# Docker Image Versions
echo "DOCKERID=${DOCKERID}
NGINX_REPOSITORY=${NGINX_REPOSITORY}
NGINX_GENEESPLAATS_NL_IMAGE=${DOCKERID}/${NGINX_REPOSITORY}
NGINX_GENEESPLAATS_NL_VERSION=${RELEASE_VERSION}" >> .nginx_env

echo Generated file .nginx_env

