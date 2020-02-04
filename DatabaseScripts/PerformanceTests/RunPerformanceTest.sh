#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

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

#Define scriptFile path variables
function define_scripts {
    performanceTestScriptPath="/DatabaseScripts/PerformanceTests"
    readonly insertTextSeparatorScript="$performanceTestScriptPath/InsertTextSeparator.sh"
    readonly runQueriesScript="$performanceTestScriptPath/RunQueries.sh"
    readonly applyIndexesScript="$performanceTestScriptPath/ApplyIndexes.sh"
}

function define_files {
    #TODO: have separate srcript which hosts the queries, and test result files
    # so I can pull it here and get the arrays. This script can be used then from this file
    # and also from RunQueries file as well
    # Construct all of them in one script and source it here and in RunQueries
    
    local -n currentQueryResults=$1
    local -n currentQuries=$2
    local -n currentSqlQuries=$3
    local -n currentJsonbQuries=$4

    currentQueryResults=("Query1FullLog.txt" "Query2FullLog.txt" "Query3FullLog.txt" "Query4FullLog.txt" "Query5FullLog.txt" "Query6FullLog.txt" "Query7FullLog.txt")
    currentQuries=("Query1" "Query2" "Query3" "Query4" "Query5" "Query6" "Query7")
    currentSqlQuries=("Query1.sql" "Query2.sql" "Query3.sql" "Query4.sql" "Query5.sql" "Query6.sql" "Query7.sql")
    currentJsonbQuries=("Query1JSONB.sql" "Query2JSONB.sql" "Query3JSONB.sql" "Query4JSONB.sql" "Query5JSONB.sql" "Query6JSONB.sql" "Query7JSONB.sql")
}

function print_queries {
    currentQueries=$1

    for i in "${!currentQueries[@]}"
        do
            currentQueryName="${currentQueries[i]}"
            currentQueryFile="$queriesPath/$currentQueryName"
            currentLogFile="${queryResults[i]}"
            echo "" >> "$currentLogFile"
            cat "$currentQueryFile" >> "$currentLogFile"
            echo "" >> "$currentLogFile"
        done
}

#Run sql queries - NEW
# refactor it in a way that first all sql queries are executed
# then all jsonb queries are executed
# so that in the log files we can write the results first from quries to sql
# then to jsonb. This way the log file will be much cleaner

function run_queries {
    # initial print of queries to log files
    print_queries "$sqlQuries"

    # run queries based on input counter
    for i in $(seq 1 $queryRunCounter); do
        # print intital message about query run count to result log files        
        for j in "${queryResults[@]}"
        do
            currentFile="$logsPath/$j"
            echo "This is query run number $i" >> "$currentFile"
            echo "" >> "$currentFile"
        done
        # run all sql queries
        bash "$runQueriesScript" "$logsPath" "sql"
    done

    # initial print of queries to log files
    print_queries "$jsonbQuries"

    # run queries based on input counter
    for i in $(seq 1 $queryRunCounter); do
        # print intital message about query run count to result log files 
        for i in "${queryResults[@]}"
        do
            currentFile="$logsPath/$i"
            echo "This is query run number $i" >> "$currentFile"
            echo "" >> "$currentFile"
        done
        # run all jsonb queries
        bash "$runQueriesScript" "$logsPath" "jsonb"
    done
}

#Create Test result file
function create_test_result_log_files {
    rm -rf "$logsPath"
    mkdir -p "$logsPath"

    for i in "${queryResults[@]}"
    do
        touch "$logsPath/$i"
        truncate -s 0 "$logsPath/$i" 
    done
}

# Create a general log file where execution logs will be logged
function create_general_log_file {
    logFile="$logsPath/ExecutionLog.txt"
    touch "$logFile"
    truncate -s 0 "$logFile"
}

#Apply indexes to the database tables
function apply_indexes {
    for i in "${queryResults[@]}"
        do
            currentFile="$logsPath/$i"
            echo "Applying Indexes..." >> "$currentFile"
            bash "$applyIndexes"
            echo "Applying Indexes Finished!" >> "$currentFile"
            echo "Retrun queries after Indexes are applied..." >> "$currentFile"
        done
        run_queries
}
    
#Run main function as the main script flow
function main {
    #default value of queryRunCounter is 1 and default value of withIndexes is "".
    queryRunCounter=1
    withIndexes=""
    
    process_input_parameters $@
    readonly logsPath="/DatabaseScripts/PerformanceTestResults"
    readonly queriesPath="/DatabaseScripts/PerformanceTests/Queries"
    define_scripts
    
    local queryResults
    local quries
    local sqlQuries
    local jsonbQuries
    define_files queryResults quries sqlQuries jsonbQuries

    create_test_result_log_files
    create_general_log_file

    echo 'Running queries, this could take a while...'
    run_queries
    
    if [ "$withIndexes" = "withIndex" ]
    then
        apply_indexes
    fi

    echo 'Running quries finished!'
    echo ''
    echo 'Performance test execution logs:'
    cat $logFile
    echo ''
    echo 'For results please view the log files.:'
}

main $@