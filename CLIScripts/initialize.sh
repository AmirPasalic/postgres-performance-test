#!/usr/bin/env bash

#Define constants used in this script
function define_constants {
    readonly SCRIPT_DIRRECTORY_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    readonly PROJECT_MAIN_DIR_PATH="$(dirname "$SCRIPT_DIRRECTORY_PATH")"
    source "$PROJECT_MAIN_DIR_PATH/Common/constants.sh"
    source "$PROJECT_MAIN_DIR_PATH/Common/default_script_setup.sh"
}

#Show help for the command
function help {
    echo ""
    echo "NAME"
    echo "$TAB initialize.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$TAB initialize.sh help page"
    echo "$TAB This command creates a test database called CarReservationsDb and seeds test"
    echo "$TAB data to that database."
    echo "$TAB It will create standard pure sql schema tables and jsonb tables with structure: ."
    echo "$TAB Id as uuid and data as JOSNB."
    echo ""
    echo "$TAB This database with its tables and data is used for running the performance test."
    echo "$TAB More infos on that you can find by visiting the help page of the performance-test.sh."
    echo "$TAB Example performance-test.sh --help or performance-test.sh -h"
    echo ""
    echo "$TAB This database can be removed with all its data with the cleanup.sh command."
    echo "$TAB More infos on that you can find by visiting the help page of the cleanup.sh."
    echo "$TAB Example: cleanup.sh --help or cleanup.sh -h"
    echo ""
    echo "$TAB Options:"
    echo ""
    echo "$TAB -rn, --recordNumber"
    echo "$DOUBLE_TAB Record number that should be used for the Initialization of the CarReservationsDb database." 
    echo ""
}

#Handle input parameters for the script
function handle_parameters {
    parameter1=${1-default}
    case $parameter1 in
        -h | --help )
            help
            exit 0;;                 
    esac
}

#Run main function as the main script flow
function main {
    define_constants
    handle_parameters $@
    
    docker-compose -f "$PROJECT_MAIN_DIR_PATH/docker-compose-postgres.yml" up -d --build
    sleep 2s

    # create database and seed data
    docker exec -it postgres-db bash ./DatabaseScripts/Setup/create_database.sh $@

    rm -r ~/PostgresPerformanceProject/DatabaseSetup/
    mkdir -p ~/PostgresPerformanceProject/DatabaseSetup/
    
    # save Database setup logs to host machine
    docker exec -it postgres-db cat "/DatabaseScripts/SetupSummary/CarReservationsDbSetupSummary.txt" > ~/PostgresPerformanceProject/DatabaseSetup/CarReservationsDbSetupSummary.txt
}

main $@
