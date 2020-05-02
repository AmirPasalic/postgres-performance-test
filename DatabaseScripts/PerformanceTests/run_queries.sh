#!/bin/bash

source /Common/default_script_setup.sh

#Executs sql queries agains the test database
function execute_query {    
    query=$1
    log_file=$2;

    psql -d "CarReservationsDb" -f "$query" >> "$log_file"
    echo "" >> "$log_file"
    bash "$insert_text_separator_script" "$log_file"
}

function run_qeury {
    #example: query_name = Query1
    query=$1
    schema_name=$2

    if [ "$schema_name" = "sql" ]
    then
        #example: sqlQuery = Query1.sql
        query_name="${query}.sql"
    else
        #example: jsonbQuery = Query1JSONB.sql
        query_name="${query}JSONB.sql"
    fi
    
    #example: summaryLogFileName = query_name + Log.txt = Query2Log.txt
    summary_log_file_name="${query}Log.txt"
    log_file="$logs_path/$summary_log_file_name"

    execute_query "$query_name" "$log_file"
}

#Run main function as the main script flow
function main {    
    local logs_path=$1
    local schema=$2
    local insert_text_separator_script="/DatabaseScripts/PerformanceTests/insert_text_separator.sh"
    
    cd /DatabaseScripts/PerformanceTests/Queries

    run_qeury "Query1" "$schema"
    run_qeury "Query2" "$schema"
    run_qeury "Query3" "$schema"
    run_qeury "Query4" "$schema"
    run_qeury "Query5" "$schema"
    run_qeury "Query6" "$schema"
    run_qeury "Query7" "$schema"
}

main $@
