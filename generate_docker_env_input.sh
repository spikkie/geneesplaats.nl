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

DOCKERID=spikkie

