#!/bin/bash
set +e
docker login gitlab.praktikum-services.ru:5050 -u ${GR_USER} -p ${GR_PASS}
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/a.voronin/sausage-store/sausage-frontend:latest
docker-compose stop frontend || true
docker-compose rm -f frontend || true
docker-compose --env-file ./.env up --force-recreate -d frontend
echo "Frontend started"