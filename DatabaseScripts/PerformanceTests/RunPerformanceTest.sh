#!/bin/bash

queryRunCounter=$1
withIndexes=$2

insertTextSeparatorScript="/DatabaseScripts/PerformanceTests/InsertTextSeparator.sh"
runQueriesScript="/DatabaseScripts/PerformanceTests/RunQueries.sh"
applyIndexesScript="/DatabaseScripts/PerformanceTests/ApplyIndexes.sh"

mkdir /DatabaseScripts/PerformanceTestResults
logFile="/DatabaseScripts/PerformanceTestResults/PerformanceTestLog.txt"
touch $logFile
truncate -s 0 logFile 

function run_queries {
    for i in $(seq 1 $1); do
        echo "This is query run number $i" >> $logFile
        bash "$runQueriesScript" "$logFile"
    done
}

run_queries $queryRunCounter
bash "$insertTextSeparatorScript" "$logFile"

if [ "$withIndexes" = "withIndex" ]
then
    echo "Applying Indexes..." >> $logFile
    bash "$applyIndexes"
    echo "Applying Indexes Finished!" >> $logFile
    echo "Rerun queries after Indexes are applied..." >> $logFile
    run_queries $queryRunCounter
fi
  
echo 'Full Log of Performance test:'
cat $logFile;