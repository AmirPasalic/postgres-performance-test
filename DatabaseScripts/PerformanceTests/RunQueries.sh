#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

#Executs sql queries agains the test database
function execute_query {    
    query=$1
    shortLog=$2;
    longLog=$3;

    #TODO:
    # this is the one with just execution time
    #psql -d "CarReservationsDb" -f "$query" >> "shortLog"

    # Execute with the long log(EXPLAIN ANALYZE)
    psql -d "CarReservationsDb" -f "$query" >> "$longLog"

    # add empy lies to the log file
    #echo "" >> $shortLog
    echo "" >> "$longLog"

    #bash "$insertTextSeparatorScript" "$shortSummaryLog"
    bash "$insertTextSeparatorScript" "$longLog"
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

    #example: shortSummaryLog = queryName + ShortLog.txt = Query1ShortLog.txt
    shortSummaryLogFileName="${query}ShortLog.txt"
    
    #example: fullSummaryLog = queryName + FullLog.txt = Query2FullLog.txt
    fullSummaryLogFileName="${query}FullLog.txt"

    shortLog="$logsPath/$shortSummaryLogFileName"
    longLog="$logsPath/$fullSummaryLogFileName"

    execute_query "$queryName" "$shortLog" "$longLog"
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