#!/bin/bash

#Exit when any command fails
set -e

#Handle input arguments
function handle_arguments {
        case $1 in 
            -c | --counter )
                queryRunCounter=$2;;
            -wi | --withIndex )    
                withIndexes=$2;;
            *)
                queryRunCounter=1
                withIndexes="";;                     
        esac
}

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ] && [ "$#" -ne 2 ] && [ "$#" -ne 4 ]; then
        echo ERROR: number of option parameters is not corrext. 1>&2
        exit 1
    fi

    if [ "$#" -eq 0 ] 
    then
        queryRunCounter=1
    fi

    if [ "$#" -eq 2 ] 
    then
        handle_arguments $1 $2
    fi

    if [ "$#" -eq 4 ] 
    then
        handle_arguments $3 $4
    fi
}

#Run sql queries
function run_queries {
    for i in $(seq 1 $queryRunCounter); do
        echo "This is query run number $i" >> $logFile
        bash "$runQueriesScript" "$logFile"
    done
}

#Apply indexes to the database tables
function apply_indexes {
    echo "Applying Indexes..." >> $logFile
    bash "$applyIndexes"
    echo "Applying Indexes Finished!" >> $logFile
    echo "Rerun queries after Indexes are applied..." >> $logFile
    run_queries
}

#Run main function as the main script flow
function main {
    #default value of queryRunCounter is 1.
    queryRunCounter=1
    #default value of withIndexes is "".
    withIndexes=""
    
    process_input_parameters $@

    #Define scriptFile path variables
    insertTextSeparatorScript="/DatabaseScripts/PerformanceTests/InsertTextSeparator.sh"
    runQueriesScript="/DatabaseScripts/PerformanceTests/RunQueries.sh"
    applyIndexesScript="/DatabaseScripts/PerformanceTests/ApplyIndexes.sh"

    #Create Test result file
    mkdir /DatabaseScripts/PerformanceTestResults
    logFile="/DatabaseScripts/PerformanceTestResults/PerformanceTestLog.txt"
    touch $logFile
    truncate -s 0 $logFile 
    
    #Run queries
    run_queries
    bash "$insertTextSeparatorScript" "$logFile"

    if [ "$withIndexes" = "withIndex" ]
    then
        apply_indexes
    fi

    echo 'Full Log of Performance test:'
    cat $logFile;
}

main $@