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

#Removes indexes from tables in CarReservationsDb database
function remove_indexes {
    local full_remove_indexes_file_path="/DatabaseScripts/PerformanceTests/Indexes/RemoveIndexes.sql"
    local database="CarReservationsDb"

    print_to_execution_log_and_stdout "Removing indexes!"
    print_to_execution_log_and_stdout "Index removing started..."
    print_to_execution_log_and_stdout "Note: Indexes will only be removed if they exist."

    #create function
    psql -d "$database" -f "$full_remove_indexes_file_path"
    
    #call function
    psql -d "$database" -c "SELECT remove_indexes()" -f "$full_remove_indexes_file_path"
    print_to_execution_log_and_stdout "Removing indexes finished."
}

#Run main function as the main script flow
function main {
    process_input_parameters $@
    remove_indexes
}

main $@