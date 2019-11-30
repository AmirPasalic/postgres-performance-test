#!/bin/bash

#Cleanup containers
docker-compose -f "../docker-compose-postgres.yml" down -v