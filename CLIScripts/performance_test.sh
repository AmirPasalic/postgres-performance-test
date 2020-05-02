#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

#Show help for the command
function help {
    readonly tab="    " #used as replacement for echo /t has inconsistencies for different terminal clients app emulators
    readonly double_tab="        "
    echo ""
    echo "NAME"
    echo "$tab performance-test.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$tab performance-test.sh help command page"
    echo "$tab This command executes the performance test on a test database."
    echo "$tab In order to setup the test database you need to run the command: bash initialize.sh."
    echo "$tab More infos on that you can find by visiting the help page of the initialize.sh."
    echo "$tab Example: initialize.sh --help or initialize.sh -h"
    echo ""
    echo "$tab performance-test.sh help command will run the test queries on the CarReservationsDb."
    echo "$tab Each query run on CarReservationsDb will run on a Standard SQL based schema and on JSONB based schema."
    echo "$tab By default the command: performance-test.sh will run the queries on the database only once and"
    echo "$tab without applying indexes."
    echo ""
    echo "$tab Options:"
    echo ""
    echo "$tab -c, --counter"
    echo "$double_tab Counter for how many time the querie execution should be repeated." 
    echo "$double_tab Example would be performance-test.sh -c 3"
    echo ""
    echo "$tab -wi, --withIndex"
    echo "$double_tab Parameter which indicates if indexes should be applied to the database after the first query run." 
    echo "$double_tab Example would be performance-test.sh -wi"
    echo "$double_tab This would run the queries before applying the indexes and once again after applying the indexes"
    echo "$double_tab to the database."
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
    handle_arguments "$@"

    # run queries on schemas
    docker exec -it postgres-db bash ./DatabaseScripts/PerformanceTests/run_performance_test.sh "$@"

    rm -r ~/PostgresPerformanceProject/PerformanceTestResults
    mkdir -p ~/PostgresPerformanceProject/PerformanceTestResults
    
    # copy performance test results to host machine
    docker cp postgres-db:/DatabaseScripts/PerformanceTestResults/ ~/PostgresPerformanceProject/PerformanceTestResults
}

main "$@"
