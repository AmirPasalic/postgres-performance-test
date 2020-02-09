#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

#Executs sql queries agains the test database
function execute_query {    
    query=$1
    logFile=$2;

    psql -d "CarReservationsDb" -f "$query" >> "$logFile"
    echo "" >> "$logFile"
    bash "$insertTextSeparatorScript" "$logFile"
}

function run_qeury {
    #example: queryName = Query1
    query=$1
    schemaName=$2

    if [ "$schemaName" = "sql" ]
    then
        #example: sqlQuery = Query1.sql
        queryName="${query}.sql"
    else
        #example: jsonbQuery = Query1JSONB.sql
        queryName="${query}JSONB.sql"
    fi
    
    #example: summaryLogFileName = queryName + Log.txt = Query2Log.txt
    summaryLogFileName="${query}Log.txt"
    logFile="$logsPath/$summaryLogFileName"

    execute_query "$queryName" "$logFile"
}

#Run main function as the main script flow
function main {    
    logsPath=$1
    schema=$2
    readonly insertTextSeparatorScript="/DatabaseScripts/PerformanceTests/InsertTextSeparator.sh"
    
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
