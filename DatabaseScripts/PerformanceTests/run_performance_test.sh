#!/bin/bash

source /Common/default_script_setup.sh
source /Common/constants.sh

#Handle input parameters
function handle_parameters {
        case $1 in 
            -c | --counter )
                #if argument $2 does not have value or is not a number
                if [ -z "${2+x}" ] || ! [[ $2 =~ $IS_NUMBER_REG_EXP ]] ; then
                    echo ERROR: When using -c or --counter you need to specify a number as second parameter.
                    exit 1
                fi
                query_run_counter=$2;;
            -wi | --withIndex )    
                with_indexes=true;;                   
        esac

        # if $2 has a value
        if [ -n "${2+x}" ]
        then
            case $2 in 
                -c | --counter )
                    #if argument $3 does not have value or is not a number
                    if [ -z "${3+x}" ] || ! [[ $3 =~ $IS_NUMBER_REG_EXP ]] ; then
                        echo ERROR: When using -c or --counter you need to specify a number as second parameter.
                        exit 1
                    fi
                    query_run_counter=$3;;
                -wi | --withIndex )    
                    with_indexes=true;;                 
        esac
        fi

        # if $3 has a value
        if [ -n "${3+x}" ]
        then
            case $3 in 
                -wi | --withIndex )    
                    with_indexes=true;;                 
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
        query_run_counter=1
    fi

    if [ "$#" -eq 1 ] 
    then
        handle_parameters $1
    fi

    if [ "$#" -eq 2 ] 
    then
        handle_parameters $1 $2
    fi

    if [ "$#" -eq 3 ] 
    then
        handle_parameters $1 $2 $3
    fi
}

#Will print given message to ExecutionLog.txt and to stdout of current execution terminal
function print_to_execution_log_and_stdout {
    current_message=$1
    if [ "$current_message" != "" ]
    then
        timeStamp=$(date '+%F %T.%3N') #timestamp with miliseconds precision
        current_message="$timeStamp: ${current_message}"
    fi
    echo "$current_message" >> "$execution_log_file"
    echo "$current_message"
}

#Define scriptFile path variables
function define_scripts {
    performanceTestScriptPath="/DatabaseScripts/PerformanceTests"
    readonly run_queries_script="$performanceTestScriptPath/run_queries.sh"
    readonly apply_indexes_script="$performanceTestScriptPath/apply_indexes.sh"
}

#Define query and result log files
function define_files {    
    local -n current_query_results=$1
    local -n current_quries=$2
    local -n current_sql_quries=$3
    local -n current_jsonb_quries=$4

    current_query_results=("Query1Log.txt" "Query2Log.txt" "Query3Log.txt" "Query4Log.txt" "Query5Log.txt" "Query6Log.txt" "Query7Log.txt")
    current_quries=("Query1" "Query2" "Query3" "Query4" "Query5" "Query6" "Query7")
    current_sql_quries=("Query1.sql" "Query2.sql" "Query3.sql" "Query4.sql" "Query5.sql" "Query6.sql" "Query7.sql")
    current_jsonb_quries=("Query1JSONB.sql" "Query2JSONB.sql" "Query3JSONB.sql" "Query4JSONB.sql" "Query5JSONB.sql" "Query6JSONB.sql" "Query7JSONB.sql")
}

#Initial printing of queries to result Log files
function print_queries {
    current_queries=("$@")

    for i in "${!current_queries[@]}"
        do
            current_query_name="${current_queries[i]}" #example: will be Query1.sql or Quer1JSONB.sql 
            current_query_file="$QUERIES_PATH/$current_query_name"
            current_log_file="$LOGS_PATH/${query_results[i]}"
            echo "" >> "$current_log_file"
            cat "$current_query_file" >> "$current_log_file"
            echo "" >> "$current_log_file"
        done
}

#Running queries
function run_queries {
    # initial print of queries to log files
    print_queries "${sql_quries[@]}"

    # run queries based on input counter
    for i in $(seq 1 $query_run_counter); do
        # print intital message about query run count to result log files
        print_to_execution_log_and_stdout "Query run number $i for SQL queries is running:"

        for j in "${query_results[@]}"
        do
            local current_file="$LOGS_PATH/$j"
            echo "" >> "$current_file"
            echo "This is query run number $i:" >> "$current_file"
            echo "" >> "$current_file"
        done
        # run all sql queries
        print_to_execution_log_and_stdout "Running SQL queries..."
        bash "$run_queries_script" "$LOGS_PATH" "sql"
    done

    # initial print of queries to log files
    print_queries "${jsonb_quries[@]}"

    # run queries based on input counter
    for i in $(seq 1 $query_run_counter); do
        # print intital message about query run count to result log files 
        print_to_execution_log_and_stdout "Query run number $i for JSONB queries is running:"

        for j in "${query_results[@]}"
        do
            current_file="$LOGS_PATH/$j"
            echo "" >> "$current_file"
            echo "This is query run number $i:" >> "$current_file"
            echo "" >> "$current_file"
        done
        # run all jsonb queries
        print_to_execution_log_and_stdout "Running JSONB queries..."
        bash "$run_queries_script" "$LOGS_PATH" "jsonb"
    done
}

#Create test result file
function create_test_result_log_files {
    rm -rf "$LOGS_PATH"
    mkdir -p "$LOGS_PATH"

    for i in "${query_results[@]}"
    do
        touch "$LOGS_PATH/$i"
        truncate -s 0 "$LOGS_PATH/$i" 
    done
}

# Create a general log file where execution logs will be logged
function create_execution_log_file {
    execution_log_file="$LOGS_PATH/ExecutionLog.txt"
    touch "$execution_log_file"
    truncate -s 0 "$execution_log_file"
    echo "Execution Log for performance test: " >> $execution_log_file
    echo "" >> "$execution_log_file"
}

#Apply indexes to the database tables
function apply_indexes {
    for i in "${query_results[@]}"
        do
            local current_file="$LOGS_PATH/$i"
            print_to_execution_log_and_stdout "Applying indexes..."
            
            # bash "$apply_indexes_script"
            echo "Applying Indexes Finished!" >> "$current_file"
            
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
    # default value of query_run_counter is 1 and default value of with_indexes is false.
    local query_run_counter=1
    local with_indexes=false
    
    process_input_parameters $@
    readonly LOGS_PATH="/DatabaseScripts/PerformanceTestResults"
    readonly QUERIES_PATH="/DatabaseScripts/PerformanceTests/Queries"
    define_scripts
    
    local query_results
    local quries
    local sql_quries
    local jsonb_quries

    define_files query_results quries sql_quries jsonb_quries
    create_test_result_log_files
    create_execution_log_file

    print_to_execution_log_and_stdout "Starting execution of queries. This could take a while..."
    run_queries
    
    if [ "$with_indexes" = true ]
    then
        echo "Applying Indexes: " >> $execution_log_file
        echo 'Applying indexes and re-running queries again, this could take a while as well...'
        apply_indexes
    fi

    print_summary_message
}

main $@
