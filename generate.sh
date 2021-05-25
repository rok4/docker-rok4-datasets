#!/bin/bash

mkdir -p scripts pyramids

tag="latest"
if [[ ! -z $1 ]]; then
    tag=$1
fi

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
    rok4/rok4generation:${tag} \
    /bin/bash -c "be4-file.pl --conf /confs/BDORTHO.main && bash /scripts/main.sh 10 && create-layer.pl --pyramid=/pyramids/BDORTHO/BDORTHO.pyr --tmsdir=/etc/rok4/config/tileMatrixSet >/pyramids/BDORTHO/BDORTHO.lay"

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
    rok4/rok4generation:${tag} \
    /bin/bash -c "be4-file.pl --conf /confs/ALTI.main && bash /scripts/main.sh 10 && create-layer.pl --pyramid=/pyramids/ALTI/ALTI.pyr --tmsdir=/etc/rok4/config/tileMatrixSet >/pyramids/ALTI/ALTI.lay"


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
    rok4/rok4generation:${tag} \
    /bin/bash -c "4alamo-file.pl --conf /confs/LIMADM.main && sleep 30 && bash /scripts/main.sh 10 && create-layer.pl --pyramid=/pyramids/LIMADM/LIMADM.pyr --tmsdir=/etc/rok4/config/tileMatrixSet >/pyramids/LIMADM/LIMADM.lay"

docker stop fouralamo-limadm-postgis
docker network rm fouralamo-limadm
