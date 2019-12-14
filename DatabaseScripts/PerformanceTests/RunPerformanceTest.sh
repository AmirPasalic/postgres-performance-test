#!/bin/bash

queryRunCounter=$1
withIndexes=$2

mkdir /DatabaseScripts/PerformanceTestResults
logFile="/DatabaseScripts/PerformanceTestResults/PerformanceTestLog.txt"
touch $logFile
truncate -s 0 logFile 

function run_queries {
    for i in $(seq 1 $1); do
        bash RunQueries $logFile
    done
}

bash run_queries $queryRunCounter

if [$withIndexes = "withIndex"]
then
    echo "Applying Indexes..." >> $logFile
    bash ApplyIndexes.sh
    echo "Applying Indexes Finished!" >> $logFile
    echo "Rerun queries after Indexes are applied..." >> $logFile
    bash run_queries $queryRunCounter
fi
  
echo 'Full Log of Performance test:'
cat $logFile;