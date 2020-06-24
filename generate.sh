#!/bin/bash

mkdir -p scripts pyramids

image="ALL"
if [[ ! -z $1 ]]; then
    image=$1
fi

if [[ "$image" = "BDORTHO" || "$image" = "ALL" ]]; then
    if [[ -d ./pyramids/BDORTHO ]]; then
        rm -r ./pyramids/BDORTHO
    fi

    ### BE4
    rm ./scripts/*
    docker run --rm --name be4-ortho \
        --user $(id -u):$(id -g) \
        -v $PWD/confs:/confs:ro \
        -v $PWD/data:/data:ro \
        -v $PWD/pyramids:/pyramids \
        -v $PWD/scripts:/scripts \
        rok4/rok4generation:3.7.2-buster \
        /bin/bash -c "be4-file.pl --conf /confs/BDORTHO.main && bash /scripts/main.sh 10 && create-layer.pl --pyr=/pyramids/BDORTHO/BDORTHO.pyr --tmsdir=/etc/rok4/config/tileMatrixSet --layerdir=/pyramids/BDORTHO"

    ### WMTSALAD
    docker run --rm --name wmtsalad-ortho \
        --user $(id -u):$(id -g) \
        -v $PWD/confs:/confs:ro \
        -v $PWD/pyramids:/pyramids \
        rok4/rok4generation:3.7.2-buster \
        /bin/bash -c "wmtSalaD.pl --conf /confs/BDORTHO-WOD.main --dsrc=/confs/BDORTHO-WOD.datasources && create-layer.pl --pyr=/pyramids/BDORTHO/BDORTHO-WOD.pyr --tmsdir=/etc/rok4/config/tileMatrixSet --layerdir=/pyramids/BDORTHO"
fi

if [[ "$image" = "ALTI" || "$image" = "ALL" ]]; then
    if [[ -d ./pyramids/ALTI ]]; then
        rm -r ./pyramids/ALTI
    fi

    ### BE4
    rm ./scripts/*
    docker run --rm --name be4-alti \
        --user $(id -u):$(id -g) \
        -v $PWD/confs:/confs:ro \
        -v $PWD/data:/data:ro \
        -v $PWD/pyramids:/pyramids \
        -v $PWD/scripts:/scripts \
        rok4/rok4generation:3.7.2-buster \
        /bin/bash -c "be4-file.pl --conf /confs/ALTI.main && bash /scripts/main.sh 10 && create-layer.pl --pyr=/pyramids/ALTI/ALTI.pyr --tmsdir=/etc/rok4/config/tileMatrixSet --layerdir=/pyramids/ALTI"

fi

if [[ "$image" = "LIMADM" || "$image" = "ALL" ]]; then
    if [[ -d ./pyramids/LIMADM ]]; then
        rm -r ./pyramids/LIMADM
    fi

    ### POSTGIS
    docker network create --driver=bridge --subnet=10.210.0.0/16 fouralamo-limadm

    docker run --rm -d --name fouralamo-limadm-postgis \
        --network fouralamo-limadm \
        -e POSTGRES_DB=ign \
        -e POSTGRES_USER=ign \
        -e POSTGRES_PASSWORD=ign \
        -v $PWD/data/limadm.sql:/docker-entrypoint-initdb.d/limadm.sql \
        postgis/postgis:12-3.0-alpine

    sleep 5

    ### 4ALAMO
    rm ./scripts/*
    docker run --rm -it --name test-rok4generation \
        --user $(id -u):$(id -g) \
        --network fouralamo-limadm \
        -v $PWD/confs:/confs:ro \
        -v $PWD/data:/data:ro \
        -v $PWD/pyramids:/pyramids \
        -v $PWD/scripts:/scripts \
        rok4/rok4generation:3.7.2-buster \
        /bin/bash -c "4alamo-file.pl --conf /confs/LIMADM.main && sleep 30 && bash /scripts/main.sh 10 && create-layer.pl --pyr=/pyramids/LIMADM/LIMADM.pyr --tmsdir=/etc/rok4/config/tileMatrixSet --layerdir=/pyramids/LIMADM"

    docker stop fouralamo-limadm-postgis
    docker network rm fouralamo-limadm
fi