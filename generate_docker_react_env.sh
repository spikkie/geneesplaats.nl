#/usr/bin/env bash 
set -x
set -e

. ./generate_docker_env_input.sh

if [[ "${ENVIRONMENT}" = 'production' ]];then
    DEBUG=1
    REACT_APP_EXPOSE_PORT=8000
elif [[ "${ENVIRONMENT}" = 'development' ]];then
    DEBUG=1
    REACT_APP_EXPOSE_PORT=8001
elif [[ "${ENVIRONMENT}" = 'development_test' ]];then
    DEBUG=1
    REACT_APP_EXPOSE_PORT=8002
elif [[ "${ENVIRONMENT}" = 'production_test' ]];then
    DEBUG=1
    REACT_APP_EXPOSE_PORT=8003
else
    >&2 echo "Error: ENVIRONMENT ${ENVIRONMENT} not correct"
    exit 1
fi

echo "
DEBUG=$DEBUG
ENVIRONMENT=$ENVIRONMENT
REACT_APP_EXPOSE_PORT=${REACT_APP_EXPOSE_PORT}
REACT_APP_BASE_URL=${REACT_APP_BASE_URL}" > .docker-env-base-react-${ENVIRONMENT}

if [[ ! -f .docker-env-base-react-${ENVIRONMENT} ]];then
    echo Error: Strange file .docker-env-base-react-${ENVIRONMENT} does not exist
    exit 1
else
    cat .docker-env-base-react-${ENVIRONMENT} > .react_env
fi

REACT_REPOSITORY=react_geneesplaats_nl_${ENVIRONMENT}
# Docker Images
# Docker Image Versions
echo "DOCKERID=${DOCKERID}
REACT_REPOSITORY=${REACT_REPOSITORY}
REACT_GENEESPLAATS_NL_IMAGE=${DOCKERID}/${REACT_REPOSITORY}
REACT_GENEESPLAATS_NL_VERSION=${RELEASE_VERSION}
REACT_APP_TEST=TEST" >> .react_env

echo Generated file .react_env
