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
    echo "$TAB ppt_performance-test"
    echo ""
    echo "DESCRIPTION"
    echo "$TAB ppt_performance-test help command page"
    echo "$TAB This command executes the performance test on a test database."
    echo "$TAB In order to setup the test database you need to run the command: ppt_initialize."
    echo "$TAB More infos on that you can find by visiting the help page of the ppt_initialize command."
    echo "$TAB Example: ppt_initialize --help or ppt_initialize -h"
    echo ""
    echo "$TAB ppt_performance-test help command will run the test queries on the CarReservationsDb."
    echo "$TAB Each query run on CarReservationsDb will run on a Standard SQL based schema and on JSONB based schema."
    echo "$TAB By default the command: ppt_performance-test will run the queries on the database only once and"
    echo "$TAB without applying indexes."
    echo ""
    echo "$TAB Options:"
    echo ""
    echo "$TAB -c, --counter"
    echo "$DOUBLE_TAB Counter for how many time the querie execution should be repeated." 
    echo "$DOUBLE_TAB Example would be ppt_performance-test -c 3"
    echo ""
    echo "$TAB -wi, --withIndex"
    echo "$DOUBLE_TAB Parameter which indicates if indexes should be applied to the database after the first query run." 
    echo "$DOUBLE_TAB Example would be ppt_performance-test -wi"
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
    define_constants
    handle_parameters "$@"

    # run queries on schemas
    docker exec -it postgres-db bash ./DatabaseScripts/PerformanceTests/run_performance_test.sh "$@"

    rm -rf ~/PostgresPerformanceProject/PerformanceTestResults/
    mkdir -p ~/PostgresPerformanceProject/PerformanceTestResults
    
    # copy performance test results to host machine
    docker cp postgres-db:/DatabaseScripts/PerformanceTestResults/ ~/PostgresPerformanceProject
}

main "$@"
