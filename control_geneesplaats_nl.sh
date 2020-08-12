#!/usr/bin/env bash 
set -x 
set -e

Functions=('build' 'force_build' 'deploy' 'up' 'up_postgres'  'down_postgres' 'down' 'stop' 'clean' 'kompose_up' 'kompose_convert' 'test' 'config')
Environments=('development' 'test' 'stash' 'production')


generate_env() {
    echo generate environment
    if [[ -f ./.env ]]; then
        rm ./.env
    fi

    #check if we have configuration set
        #not set so lets generate it
    if [[ ! -f ./.docker-env-postgres-$ENVIRONMENT ]]; then
        ./generate_docker_postgres_env.sh  $ENVIRONMENT $RELEASE_VERSION
    fi
    if [[ ! -f ./.docker-env-react-$ENVIRONMENT ]]; then
        ./generate_docker_react_env.sh $ENVIRONMENT $RELEASE_VERSION
    fi
    if [[ ! -f ./.docker-env-nginx-$ENVIRONMENT ]]; then
        ./generate_docker_nginx_env.sh $ENVIRONMENT $RELEASE_VERSION
    fi

    echo generate geneesplaats.nl for $ENVIRONMENT environment -- release $RELEASE_VERSION

    echo set environment variabels:
    cat ./.postgres_env
    cat ./.react_env
    # cat ./.nginx_env

    cat ./.postgres_env > ./.env
	cat ./.react_env >> ./.env
    # cat ./.nginx_env >> ./.env

}

build() {
    generate_env
    echo build
    # docker-compose -f docker-compose-$ENVIRONMENT.yml build
    docker-compose -f docker-compose-$ENVIRONMENT.yml build
    docker-compose -f docker-compose-$ENVIRONMENT.yml push
}

force_build() {
    generate_env
    echo force_build
    # docker-compose --progress auto --verbose  -f docker-compose-$ENVIRONMENT.yml build --no-cache --force-rm 
    docker-compose --verbose  -f docker-compose-$ENVIRONMENT.yml build --no-cache --force-rm 
    docker-compose -f docker-compose-$ENVIRONMENT.yml push
}

deploy() {
    generate_env
    echo deploy
}

stop() {
    generate_env
    echo stop
}

clean() {
    generate_env
    echo clean
}

up() {
    generate_env
    # docker-compose --log-level DEBUG -f docker-compose-$ENVIRONMENT.yml up --no-build
    docker-compose -f docker-compose-$ENVIRONMENT.yml up --no-build

    #todo
    #docker stack deploy my-stack --compose-file docker-compose.yml --with-registry-auth
}

up_postgres() {
    generate_env
    docker-compose -f docker-compose-${ENVIRONMENT}-postgres-only.yml up --no-build
}

down_postgres() {
    generate_env
    docker-compose -f docker-compose-${ENVIRONMENT}-postgres-only.yml down
}

down() {
    generate_env
    docker-compose -f docker-compose-$ENVIRONMENT.yml down
}

kompose_up() {
    echo kompose up
    config
    kompose up -v  --build="none" --store-manifest --server https://172.17.0.2:8443 -f docker-compose-$ENVIRONMENT.config.test.yml
}
kompose_convert() {
    echo kompose convert
    config
    if [[ -d kompose_$ENVIRONMENT ]]; then
        rm -rf kompose_$ENVIRONMENT
    fi
    mkdir kompose_$ENVIRONMENT
    kompose convert -v -f docker-compose-$ENVIRONMENT.config.yml -o kompose_$ENVIRONMENT
}
test() {
    echo  docker-compose test
    docker exec -it $(ddi) python manage.py test  -v3
}

config() {
    set +x
    echo docker-compose -f docker-compose-$ENVIRONMENT.yml config
    generate_env
    docker-compose -f docker-compose-$ENVIRONMENT.yml config | tee docker-compose-$ENVIRONMENT.config.yml
    set -x
}

if [[ $# < 2 ]]; then
    echo Error: at least 2 parameter are required identifying the environment
    echo 
    echo First parameter is "what to do", one of these values:
    echo ${Functions[@]}
    echo Second parameter is "in which environment", one of these values:
    echo ${Environments[@]}
    echo Third optional parameter is "version". If ommited then default value is 'latest'
    exit
fi

FUNCTION=$1
if [[ ! " ${Functions[@]} " =~ " ${FUNCTION} " ]]; then
    echo Error: 1th parameter ${FUNCTION} has to be equal to one of these values: 
    echo     ${Functions[@]}
    exit
fi

ENVIRONMENT=$2
if [[ ! " ${Environments[@]} " =~ " ${ENVIRONMENT} " ]]; then
    echo Error: 2th parameter has to be equal to one of these values: 
    echo     ${Environments[@]}
    exit
fi

if [[ $# > 2 ]]; then
    RELEASE_VERSION=$3
fi
if [[ -z $RELEASE_VERSION ]];then
    RELEASE_VERSION=latest
fi
if [[ ${FUNCTION} == 'build' ]];then
    build
elif [[ ${FUNCTION} == 'force_build' ]];then
   force_build 
elif [[ ${FUNCTION} == 'deploy' ]];then
    deploy
elif [[ ${FUNCTION} == 'up' ]];then
    up 
elif [[ ${FUNCTION} == 'up_postgres' ]];then
    up_postgres 
elif [[ ${FUNCTION} == 'down' ]];then
    down 
elif [[ ${FUNCTION} == 'stop' ]];then
    stop
elif [[ ${FUNCTION} == 'clean' ]];then
    clean
elif [[ ${FUNCTION} == 'kompose_up' ]];then
   kompose_up 
elif [[ ${FUNCTION} == 'kompose_convert' ]];then
   kompose_convert
elif [[ ${FUNCTION} == 'test' ]];then
  test 
elif [[ ${FUNCTION} == 'config' ]];then
  config 
else
    echo Error: none of the functions as defined in Functions:
    echo     ${Functions[@]}
    echo is used. 
    echo Used: ${FUNCTION}
    exit
fi
