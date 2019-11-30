#!/bin/bash

#Start the db
docker-compose -f "../docker-compose-postgres.yml" up -d --build
sleep 1s
docker exec -it postgres-db bash ./DatabaseScripts/CreateDatabase.sh

#Copy CreateDatabase.sql and execute it in the postgres docker container
# Run query on sql schema and show result
# Run query on JSONB schema and show result
# Apply indexes 
# Run query on sql schema and show result
# Run query on JSONB schema and show result
# Output the result in output summary file