#!/bin/bash
set +e
cat > .env <<EOF
DB=${SPRING_DATA_MONGODB_URI}
PORT=8082
EOF
docker login gitlab.praktikum-services.ru:5050 -u ${GR_USER} -p ${GR_PASS}
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/a.voronin/sausage-store/sausage-backend-report:latest
docker-compose stop backend-report || true
docker-compose rm -f backend-report || true
docker-compose --env-file ./.env up --force-recreate -d backend-report
echo "Backend-report started"