#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

#Show help for the command
function help {
    #used as replacement for echo /t has inconsistencies for different terminal clients app emulators
    readonly tab="    " 
    readonly double_tab="        "
    
    echo ""
    echo "NAME"
    echo "$tab initialize.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$tab initialize.sh help page"
    echo "$tab This command creates a test database called CarReservationsDb and seeds test"
    echo "$tab data to that database."
    echo "$tab It will create standard pure sql schema tables and jsonb tables with structure: ."
    echo "$tab Id as uuid and data as JOSNB."
    echo ""
    echo "$tab This database with its tables and data is used for running the performance test."
    echo "$tab More infos on that you can find by visiting the help page of the performance-test.sh."
    echo "$tab Example performance-test.sh --help or performance-test.sh -h"
    echo ""
    echo "$tab This database can be removed with all its data with the cleanup.sh command."
    echo "$tab More infos on that you can find by visiting the help page of the cleanup.sh."
    echo "$tab Example: cleanup.sh --help or cleanup.sh -h"
    echo ""
    echo "$tab Options:"
    echo ""
    echo "$tab -rn, --recordNumber"
    echo "$double_tab Record number that should be used for the Initialization of the CarReservationsDb database." 
    echo ""
}

#Handle input arguments for the script
function handle_arguments {
    argument1=${1-default}
    case $argument1 in
        -h | --help )
            help
            exit 0;;                 
    esac
}

#Run main function as the main script flow
function main {
    handle_arguments $@
    docker-compose -f "../docker-compose-postgres.yml" up -d --build
    sleep 1s

    # create database and seed data
    docker exec -it postgres-db bash ./DatabaseScripts/Setup/create_database.sh $@

    rm -r ~/PostgresPerformanceProject/DatabaseSetup/
    mkdir -p ~/PostgresPerformanceProject/DatabaseSetup/
    
    # save Database setup logs to host machine
    docker exec -it postgres-db cat "/DatabaseScripts/SetupSummary/CarReservationsDbSetupSummary.txt" > ~/PostgresPerformanceProject/DatabaseSetup/CarReservationsDbSetupSummary.txt
}

main $@
