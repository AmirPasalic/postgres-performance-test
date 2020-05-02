#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

#Handle input arguments
function handle_arguments {
        isNumberRegExpession='^[0-9]+$'
        
        case $1 in 
            -c | --counter )
                #if argument $2 does not have value or is not a number
                if [ -z "${2+x}" ] || ! [[ $2 =~ $isNumberRegExpession ]] ; then
                    echo ERROR: When using -c or --counter you need to specify a number as second parameter.
                    exit 1
                fi
                queryRunCounter=$2;;
            -wi | --withIndex )    
                withIndexes=true;;                   
        esac

        # if $2 has a value
        if [ -n "${2+x}" ]
        then
            case $2 in 
                -c | --counter )
                    #if argument $3 does not have value or is not a number
                    if [ -z "${3+x}" ] || ! [[ $3 =~ $isNumberRegExpession ]] ; then
                        echo ERROR: When using -c or --counter you need to specify a number as second parameter.
                        exit 1
                    fi
                    queryRunCounter=$3;;
                -wi | --withIndex )    
                    withIndexes=true;;                 
        esac
        fi

        # if $3 has a value
        if [ -n "${3+x}" ]
        then
            case $3 in 
                -wi | --withIndex )    
                    withIndexes=true;;                 
            esac
        fi
}

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ] && [ "$#" -ne 1 ] && [ "$#" -ne 2 ] && [ "$#" -ne 3 ]; then
        echo ERROR: number of option parameters is not correct. 1>&2
        exit 1
    fi

    if [ "$#" -eq 0 ] 
    then
        queryRunCounter=1
    fi

    if [ "$#" -eq 1 ] 
    then
        handle_arguments $1
    fi

    if [ "$#" -eq 2 ] 
    then
        handle_arguments $1 $2
    fi

    if [ "$#" -eq 3 ] 
    then
        handle_arguments $1 $2 $3
    fi
}

#Will print given message to ExecutionLog.txt and to stdout of current execution terminal
function print_to_execution_log_and_stdout {
    currentMessage=$1
    if [ "$currentMessage" != "" ]
    then
        timeStamp=$(date '+%F %T.%3N') #timestamp with miliseconds precision
        currentMessage="$timeStamp: ${currentMessage}"
    fi
    echo "$currentMessage" >> "$executionLogFile"
    echo "$currentMessage"
}

#Define scriptFile path variables
function define_scripts {
    performanceTestScriptPath="/DatabaseScripts/PerformanceTests"
    readonly runQueriesScript="$performanceTestScriptPath/run_queries.sh"
    readonly applyIndexesScript="$performanceTestScriptPath/apply_indexes.sh"
}

#Define query and result log files
function define_files {    
    local -n currentQueryResults=$1
    local -n currentQuries=$2
    local -n currentSqlQuries=$3
    local -n currentJsonbQuries=$4

    currentQueryResults=("Query1Log.txt" "Query2Log.txt" "Query3Log.txt" "Query4Log.txt" "Query5Log.txt" "Query6Log.txt" "Query7Log.txt")
    currentQuries=("Query1" "Query2" "Query3" "Query4" "Query5" "Query6" "Query7")
    currentSqlQuries=("Query1.sql" "Query2.sql" "Query3.sql" "Query4.sql" "Query5.sql" "Query6.sql" "Query7.sql")
    currentJsonbQuries=("Query1JSONB.sql" "Query2JSONB.sql" "Query3JSONB.sql" "Query4JSONB.sql" "Query5JSONB.sql" "Query6JSONB.sql" "Query7JSONB.sql")
}

#Initial printing of queries to result Log files
function print_queries {
    currentQueries=("$@")

    for i in "${!currentQueries[@]}"
        do
            currentQueryName="${currentQueries[i]}" #example: will be Query1.sql or Quer1JSONB.sql 
            currentQueryFile="$queriesPath/$currentQueryName"
            currentLogFile="$logsPath/${queryResults[i]}"
            echo "" >> "$currentLogFile"
            cat "$currentQueryFile" >> "$currentLogFile"
            echo "" >> "$currentLogFile"
        done
}

#Running queries
function run_queries {
    # initial print of queries to log files
    print_queries "${sqlQuries[@]}"

    # run queries based on input counter
    for i in $(seq 1 $queryRunCounter); do
        # print intital message about query run count to result log files
        print_to_execution_log_and_stdout "Query run number $i for SQL queries is running:"

        for j in "${queryResults[@]}"
        do
            currentFile="$logsPath/$j"
            echo "" >> "$currentFile"
            echo "This is query run number $i:" >> "$currentFile"
            echo "" >> "$currentFile"
        done
        # run all sql queries
        print_to_execution_log_and_stdout "Running SQL queries..."
        bash "$runQueriesScript" "$logsPath" "sql"
    done

    # initial print of queries to log files
    print_queries "${jsonbQuries[@]}"

    # run queries based on input counter
    for i in $(seq 1 $queryRunCounter); do
        # print intital message about query run count to result log files 
        print_to_execution_log_and_stdout "Query run number $i for JSONB queries is running:"

        for j in "${queryResults[@]}"
        do
            currentFile="$logsPath/$j"
            echo "" >> "$currentFile"
            echo "This is query run number $i:" >> "$currentFile"
            echo "" >> "$currentFile"
        done
        # run all jsonb queries
        print_to_execution_log_and_stdout "Running JSONB queries..."
        bash "$runQueriesScript" "$logsPath" "jsonb"
    done
}

#Create test result file
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
function create_execution_log_file {
    executionLogFile="$logsPath/ExecutionLog.txt"
    touch "$executionLogFile"
    truncate -s 0 "$executionLogFile"
    echo "Execution Log for performance test: " >> $executionLogFile
    echo "" >> "$executionLogFile"
}

#Apply indexes to the database tables
function apply_indexes {
    for i in "${queryResults[@]}"
        do
            currentFile="$logsPath/$i"
            print_to_execution_log_and_stdout "Applying indexes..."
            
            #bash "$applyIndexesScript"
            echo "Applying Indexes Finished!" >> "$currentFile"
            
            print_to_execution_log_and_stdout "Applying Indexes Finished!"
        done
        run_queries
}

#Prints finishing message after the execution of queries is finished
function print_summary_message {
    print_to_execution_log_and_stdout "Running quries finished!"
    print_to_execution_log_and_stdout ""

    print_to_execution_log_and_stdout "For full results please view the log files."
    echo "The execution Log can be viwed at ~/PostgresPerformanceProject/PerformanceTestResults"
}
    
#Run main function as the main script flow
function main {
    #default value of queryRunCounter is 1 and default value of withIndexes is false.
    queryRunCounter=1
    withIndexes=false
    
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
    create_execution_log_file

    print_to_execution_log_and_stdout "Starting execution of queries. This could take a while..."
    run_queries
    
    if [ "$withIndexes" = true ]
    then
        echo "Applying Indexes: " >> $executionLogFile
        echo 'Applying indexes and re-running queries again, this could take a while as well...'
        apply_indexes
    fi

    print_summary_message
}

main $@
