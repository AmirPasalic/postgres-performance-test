#!/bin/bash

$logFile=$1

function execute_query {
    cat $1 >> $logFile
    echo "" >> $logFile
    psql -d "CarReservationsDb" -f $1 >> $logFile
    echo "" >> $logFile
}

cd /DatabaseScripts/PerformanceTests/Queries
echo 'Running queries, this could take a while...'
echo "" >> $logFile

# apply Section separator output like ...... with a separate bash script
# you can use this from multiple scripts like the RunPerformanceTest.sh

execute_query Query1.sql
execute_query Query1JSONB.sql

execute_query Query2.sql
execute_query Query2JSONB.sql

execute_query Query3.sql
execute_query Query3JSONB.sql

echo 'Running quries finished!'