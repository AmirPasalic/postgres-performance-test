#!/bin/bash

#Start the db
docker-compose -f "../docker-compose-postgres.yml" up -d --build
sleep 1s
docker exec -it postgres-db bash ./DatabaseScripts/CreateDatabase.sh