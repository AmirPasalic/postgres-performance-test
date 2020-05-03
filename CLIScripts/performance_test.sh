#!/bin/bash

source ../Common/constants.sh
source ../Common/default_script_setup.sh

#Show help for the command
function help {
    echo ""
    echo "NAME"
    echo "$TAB performance-test.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$TAB performance-test.sh help command page"
    echo "$TAB This command executes the performance test on a test database."
    echo "$TAB In order to setup the test database you need to run the command: bash initialize.sh."
    echo "$TAB More infos on that you can find by visiting the help page of the initialize.sh."
    echo "$TAB Example: initialize.sh --help or initialize.sh -h"
    echo ""
    echo "$TAB performance-test.sh help command will run the test queries on the CarReservationsDb."
    echo "$TAB Each query run on CarReservationsDb will run on a Standard SQL based schema and on JSONB based schema."
    echo "$TAB By default the command: performance-test.sh will run the queries on the database only once and"
    echo "$TAB without applying indexes."
    echo ""
    echo "$TAB Options:"
    echo ""
    echo "$TAB -c, --counter"
    echo "$DOUBLE_TAB Counter for how many time the querie execution should be repeated." 
    echo "$DOUBLE_TAB Example would be performance-test.sh -c 3"
    echo ""
    echo "$TAB -wi, --withIndex"
    echo "$DOUBLE_TAB Parameter which indicates if indexes should be applied to the database after the first query run." 
    echo "$DOUBLE_TAB Example would be performance-test.sh -wi"
    echo "$DOUBLE_TAB This would run the queries before applying the indexes and once again after applying the indexes"
    echo "$DOUBLE_TAB to the database."
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
    handle_parameters "$@"

    # run queries on schemas
    docker exec -it postgres-db bash ./DatabaseScripts/PerformanceTests/run_performance_test.sh "$@"

    rm -r ~/PostgresPerformanceProject/PerformanceTestResults
    mkdir -p ~/PostgresPerformanceProject/PerformanceTestResults
    
    # copy performance test results to host machine
    docker cp postgres-db:/DatabaseScripts/PerformanceTestResults/ ~/PostgresPerformanceProject/PerformanceTestResults
}

main "$@"
