#!/usr/bin/env bash

source /Common/default_script_setup.sh

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

    echo "Removing indexes!"
    echo "Index removing started..."
    echo "Note: Indexes will only be removed if they exist."

    #create function
    psql -d "$database" -f "$full_remove_indexes_file_path"
    
    #call function
    psql -d "$database" -c "SELECT remove_indexes()" -f "$full_remove_indexes_file_path"
    echo "Removing indexes finished."
}

#Run main function as the main script flow
function main {
    process_input_parameters $@
    remove_indexes
}

main $@