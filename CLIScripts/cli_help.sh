#!/usr/bin/env bash

#Define constants used in this script
function define_constants {
    readonly SCRIPT_DIRRECTORY_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    readonly PROJECT_MAIN_DIR_PATH="$(dirname "$SCRIPT_DIRRECTORY_PATH")"
    source "$PROJECT_MAIN_DIR_PATH/Common/constants.sh"
    source "$PROJECT_MAIN_DIR_PATH/Common/default_script_setup.sh"
}

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ]; then
        echo ERROR: number of option parameters is not correct.
        exit 1
    fi
}

#ppt (Postgres Performance test) CLI Help
function help {
    echo ""
    echo "Postgres Performance test CLI Help page."
    echo "Commands:"
    echo ""
    echo "ppt_cleanup"
    echo "$TAB This command will remove the docker container where the test"
    echo "$TAB database "CarReservationsDb" was created."
    echo "$TAB This means that the database will be removed with all its data."
    echo "$TAB For help using this command please visit ppt_cleanup help page"
    echo "$TAB Example: ppt_cleanup --help or ppt_cleanup -h"
    echo ""
    echo "ppt_initialize"
    echo "$TAB This command will: "
    echo "$TAB 1. Create a docker container for PostgreSQL. In this PostgreSQL"
    echo "$TAB container a test database will be created "
    echo "$TAB called CarReservationsDb. The schema for this database will be created"
    echo "$TAB with tables structured with standard sql schema and JSONB"
    echo "$TAB based schema. 3 tables per schema type will be created."
    echo "$TAB 2. Seed some test data to this tables"
    echo "$TAB The initialize.sh script can be run with some input arguments in order to"
    echo "$TAB control how many records of the seeded data"
    echo "$TAB should be inserted. This gives the possibility to run the performance test"
    echo "$TAB on 1000 or 100000, 1 000 000 000 or any number" 
    echo "$TAB of records in particular tables."
    echo "$TAB For help using this command please visit ppt_initialize help page"
    echo "$TAB Example: ppt_initialize --help or ppt_initialize -h"
    echo ""
    echo "ppt_open_test_results"
    echo "$TAB This command will open the Directory where the performance test results are locted."
    echo "$TAB There you can find all the Query log and Execution log files."
    echo "$TAB For help using this command please visit ppt_open_test_results help page"
    echo "$TAB Example: ppt_open_test_results --help or ppt_open_test_results -h"
    echo ""
    echo "ppt_performance_test"
    echo "$TAB This command will run a set of queries on the"
    echo "$TAB CarReservationsDb. Prerequisit is of course that"
    echo "$TAB we have created the CarReservationsDb with the initialize.sh script."
    echo "$TAB Performance test can be run with some arguments like how many times the queries" 
    echo "$TAB should be run, should the queries run"
    echo "$TAB also with applied indexes on the database."
    echo "$TAB More info's on this command can be found in the help page of the performance_test.sh"
    echo "$TAB Example: performance_test.sh --help or performance_test.sh -h"
    echo ""
    echo "ppt_start_db"
    echo "$TAB This command will start the docker container which hosts the" 
    echo "$TAB CarReservationsDb which was created with the initialize.sh command."
    echo "$TAB For help using this command please visit ppt_start_db help page"
    echo "$TAB Example: ppt_start_db --help or ppt_start_db -h"
    echo ""
    echo "ppt_stop_db"
    echo "$TAB This command will stop the docker container which hosts the"
    echo "$TAB CarReservationsDb which was created with the initialize.sh command."
    echo "$TAB In order to start it again you can use the start_db.sh script."
    echo "$TAB For help using this command please visit ppt_stop_db help page"
    echo "$TAB Example: ppt_stop_db --help or ppt_stop_db -h"
    echo ""
    echo "ppt_help"
    echo "$TAB Will open the ppt CLI help page."
}

#Run main function as the main script flow
function main {
    define_constants
    process_input_parameters
    help
}

main $@