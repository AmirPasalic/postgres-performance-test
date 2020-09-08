#!/usr/bin/env bash

source /Common/default_script_setup.sh

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ]; then
        echo ERROR: number of option parameters is not correct. 1>&2
        exit 1
    fi
}

function create_indexes {
    local full_create_index_file_path="/DatabaseScripts/PerformanceTests/Indexes/CreateIndexes.sql"
    local database="CarReservationsDb"

    echo "Applying Indexes"
    echo "Index creation started..."
    echo "Note: Indexes will only be created if they do not exist so far."
    echo "If they exist this step will be skipped..."

    #create function
    psql -d "$database" -f "$full_create_index_file_path"
    
    #call function
    psql -d "$database" -c "SELECT create_indexes()" -f "$full_create_index_file_path"
    echo "Index creation finished."
}

#Run main function as the main script flow
function main {
    process_input_parameters $@
    create_indexes
}

main $@