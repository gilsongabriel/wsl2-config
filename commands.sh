#!/bin/bash

function dc {
    docker compose $1 $2 $3 $4 $5
}

function dps {
    docker ps $1 $2 $3
}

function dimg {
    docker images $1 $2 $3
}

function drm {
    docker rm $1 $2 $3
}

function drmi {
    docker rmi $1 $2 $3
}

function drmall {
    docker rm -f $(docker ps -aq)
}

function drmiall {
    docker rmi -f $(docker images -aq)
}

function dclean {
    drmall && drmiall
}

function dcup {
    dc up $1 $2 $3
}

function dcdown {
    dc down
}

function dcupb {
    dcdown && dcup $1 --build --remove-orphans
}

function dcexec {
    dc exec $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
}

function dcash {
    dcexec $1 ash -c $2 $3 $4 $5 $6 $7 $8 $9 $10
}

function composer {
    docker run --rm --interactive --tty \
        --volume $(pwd):/app \
        --user $(id -u):$(id -g) \
        composer $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
}

function laravel {
    composer create-project --prefer-dist laravel/laravel $1
}

function _node {
    docker run --rm --interactive --tty \
        --volume $(pwd):/app \
        --user $(id -u):$(id -g) \
        node:$1-alpine $2 $3 $4 $5 $6 $7 $8 $9 $10 $11 $12 $13 $14 $15 $16 $17 $18 $19 $20 $21 $22 $23 $24 $25 $26 $27 $28 $29 $30
}

function node {
    if [ $1 = '--' ]; then
        _node lts node $2 $3 $4 $5 $6 $7 $8 $9 $10
    else
        _node $1 node $2 $3 $4 $5 $6 $7 $8 $9 $10
    fi
}

function npm {
    if [ $1 = '--' ]; then
        _node lts npm $2 $3 $4 $5 $6 $7 $8 $9 $10
    else
        _node $1 npm $2 $3 $4 $5 $6 $7 $8 $9 $10
    fi
}

function nest {
    _node lts ash -c "npm i --location=global @nestjs/cli:9.0.0 && nest " $@
}

function yarn {
    _node lts yarn $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
}

function sailapp {
    curl -s "https://laravel.build/$1?with=$2" | bash
}

function sail {
    ./vendor/bin/sail $1 $2 $3 $4 $5 $6 $7 $8 $9 $10
}