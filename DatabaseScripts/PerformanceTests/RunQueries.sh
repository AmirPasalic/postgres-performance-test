#!/bin/bash

# exit when any command fails
set -e

logFile=$1
insertTextSeparatorScript="/DatabaseScripts/PerformanceTests/InsertTextSeparator.sh"

function execute_query {
    cat $1 >> $logFile
    echo "" >> $logFile
    psql -d "CarReservationsDb" -f $1 >> $logFile
    echo "" >> $logFile
}

cd /DatabaseScripts/PerformanceTests/Queries
echo 'Running queries, this could take a while...'
echo $logFile
echo "" >> $logFile

# apply Section separator output like ...... with a separate bash script
# you can use this from multiple scripts like the RunPerformanceTest.sh

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