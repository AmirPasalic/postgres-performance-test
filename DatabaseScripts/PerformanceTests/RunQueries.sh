#!/bin/bash

#Exit when any command fails
set -e

#Executs sql queries agains the test database
function execute_query {
    cat $1 >> $logFile
    echo "" >> $logFile
    psql -d "CarReservationsDb" -f $1 >> $logFile
    echo "" >> $logFile
}

#Run main function as the main script flow
function main {    
    logFile=$1
    insertTextSeparatorScript="/DatabaseScripts/PerformanceTests/InsertTextSeparator.sh"
    
    cd /DatabaseScripts/PerformanceTests/Queries
    echo 'Running queries, this could take a while...'
    echo $logFile
    echo "" >> $logFile

    bash "$insertTextSeparatorScript" "$logFile"
    execute_query Query1.sql
    execute_query Query1JSONB.sql

    bash "$insertTextSeparatorScript" $logFile
    execute_query Query2.sql
    execute_query Query2JSONB.sql

    bash "$insertTextSeparatorScript" "$logFile"
    execute_query Query3.sql
    execute_query Query3JSONB.sql

    bash "$insertTextSeparatorScript" "$logFile"
    echo 'Running quries finished!'
}

main $@