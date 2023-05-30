#!/bin/bash
set +e
cat > .env <<EOF
SPRING_DATASOURCE_URL=${SPRING_DATASOURCE_URL}
SPRING_DATASOURCE_USERNAME=${SPRING_DATASOURCE_USERNAME}
SPRING_DATASOURCE_PASSWORD=${SPRING_DATASOURCE_PASSWORD}
SPRING_DATA_MONGODB_URI=${SPRING_DATA_MONGODB_URI}
REPORT_PATH=./logs/reports
LOG_PATH=./logs
SPRING_FLYWAY_ENABLED=false
EOF
docker login gitlab.praktikum-services.ru:5050 -u ${GR_USER} -p ${GR_PASS}
docker network create -d bridge sausage_network || true
docker pull gitlab.praktikum-services.ru:5050/a.voronin/sausage-store/sausage-backend:latest

CONTAINER_NAME=(`docker ps --filter name="backend*" | grep backend  --exclude=*report* |  tr -s ' ' | rev | cut -d ' ' -f -1 | rev | head -n1`)
CONTAINER_STATUS=(`docker container inspect -f '{{.State.Status}}' $CONTAINER_NAME`)
if [[ "$CONTAINER_NAME" == "student_backend-blue_1" && "$CONTAINER_STATUS" = "running" ]]; then
  docker-compose stop backend-green || true
  docker-compose rm -f backend-green || true
  docker-compose --env-file ./.env up --force-recreate -d backend-green
  docker-compose stop backend-blue || true
  docker-compose rm -f backend-blue || true
  echo "Started green"
elif [[ "$CONTAINER_NAME" == "student_backend-green_1" && "$CONTAINER_STATUS" = "running" ]]; then
  docker-compose stop backend-blue || true
  docker-compose rm -f backend-blue || true
  docker-compose --env-file ./.env up --force-recreate -d backend-blue
  docker-compose stop backend-green || true
  docker-compose rm -f backend-green  || true
  echo "Started blue"
else
  docker-compose stop backend-green backend-blue|| true
  docker-compose rm -f backend-green backend-blue || true
  docker-compose --env-file ./.env up --force-recreate -d backend-blue
  echo "No healthy containers, started blue"
fi