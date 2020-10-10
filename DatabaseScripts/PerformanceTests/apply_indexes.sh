#!/usr/bin/env bash

source /Common/default_script_setup.sh
source /DatabaseScripts/Common/execution_log_helpers.sh

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ]; then
        echo ERROR: number of option parameters is not correct. 1>&2
        exit 1
    fi
}

#Creates all indexes for all tables CarReservationsDb
function create_indexes {
    local full_create_index_file_path="/DatabaseScripts/PerformanceTests/Indexes/CreateIndexes.sql"
    local database="CarReservationsDb"

    print_to_execution_log_and_stdout "Applying Indexes"
    print_to_execution_log_and_stdout "Index creation started..."
    print_to_execution_log_and_stdout "Note: Indexes will only be created if they do not exist so far."
    print_to_execution_log_and_stdout "If they exist this step will be skipped..."

    #create db function in Postgresql
    psql -d "$database" -f "$full_create_index_file_path"
    
    #call db function in Postgresql
    psql -d "$database" -c "SELECT create_indexes()" -f "$full_create_index_file_path"
    print_to_execution_log_and_stdout "Index creation finished."
}

#Run main function as the main script flow
function main {
    process_input_parameters $@
    create_indexes
}

main $@