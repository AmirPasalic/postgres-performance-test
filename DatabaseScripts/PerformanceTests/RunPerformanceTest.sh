#!/bin/bash

mkdir /DatabaseScripts/PerformanceTestResults
logFile="/DatabaseScripts/PerformanceTestResults/PerformanceTestLog.txt"
touch $logFile
truncate -s 0 logFile 

function execute_query {
    cat $1 >> $logFile
    echo "" >> $logFile
    psql -d "CarReservationsDb" -f $1 >> $logFile
    echo "" >> $logFile
}

cd DatabaseScripts/PerformanceTests/Queries
echo 'Running queries...'
echo "" >> $logFile

execute_query Query1.sql
execute_query Query1JSONB.sql

execute_query Query2.sql
execute_query Query2JSONB.sql

execute_query Query3.sql
execute_query Query3JSONB.sql

echo 'Running quries finished!'
echo 'Full Log of Performance test:'
cat $logFile;