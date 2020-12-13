#!/usr/bin/env bash

source /Common/default_script_setup.sh

#Executs sql queries agains the test database
function execute_query {    
    local query=$1
    local log_file=$2;

    psql -d "CarReservationsDb" -f "$query" >> "$log_file"
    echo "" >> "$log_file"
    bash "$insert_text_separator_script" "$log_file"
}

#Setup and execute the sql queries
function run_qeury {
    # example: query_name = Query1
    local query=$1
    local schema_name=$2

    if [ "$schema_name" = "sql" ]
    then
        # example: sqlQuery = Query1.sql
        query_name="${query}.sql"
    else
        # example: jsonbQuery = Query1JSONB.sql
        query_name="${query}JSONB.sql"
    fi
    
    # example: summaryLogFileName = query_name + Log.txt = Query2Log.txt
    local summary_log_file_name="${query}Log.txt"
    local log_file="$logs_path/$summary_log_file_name"
    local full_query_path="/DatabaseScripts/PerformanceTests/Queries/${query_name}"

    execute_query "$full_query_path" "$log_file"
}

#Run main function as the main script flow
function main {    
    local logs_path=$1
    local schema=$2
    local insert_text_separator_script="/DatabaseScripts/PerformanceTests/insert_text_separator.sh"

    run_qeury "Query1" "$schema"
    run_qeury "Query2" "$schema"
    run_qeury "Query3" "$schema"
    run_qeury "Query4" "$schema"
    run_qeury "Query5" "$schema"
    run_qeury "Query6" "$schema"
    run_qeury "Query7" "$schema"
    run_qeury "Query8" "$schema"
    run_qeury "Query9" "$schema"
    run_qeury "Query10" "$schema"
}

main $@
