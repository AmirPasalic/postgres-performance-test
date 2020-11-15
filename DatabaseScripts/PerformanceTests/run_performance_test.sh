#!/usr/bin/env bash

source /Common/default_script_setup.sh
source /Common/constants.sh
source /DatabaseScripts/Common/execution_log_helpers.sh

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

#Define scriptFile path variables
function define_scripts {
    performanceTestScriptPath="/DatabaseScripts/PerformanceTests"
    readonly run_queries_script="$performanceTestScriptPath/run_queries.sh"
    readonly apply_indexes_script="$performanceTestScriptPath/apply_indexes.sh"
    readonly remove_indexes_script="$performanceTestScriptPath/remove_indexes.sh"
}

#Define query and result log files
function define_files {    
    local -n current_query_results=$1
    local -n current_quries=$2
    local -n current_sql_quries=$3
    local -n current_jsonb_quries=$4

    current_query_results=("Query1Log.txt" "Query2Log.txt" "Query3Log.txt" "Query4Log.txt" "Query5Log.txt" "Query6Log.txt" "Query7Log.txt" "Query8Log.txt")
    current_quries=("Query1" "Query2" "Query3" "Query4" "Query5" "Query6" "Query7" "Query8")
    current_sql_quries=("Query1.sql" "Query2.sql" "Query3.sql" "Query4.sql" "Query5.sql" "Query6.sql" "Query7.sql" "Query8.sql")
    current_jsonb_quries=("Query1JSONB.sql" "Query2JSONB.sql" "Query3JSONB.sql" "Query4JSONB.sql" "Query5JSONB.sql" "Query6JSONB.sql" "Query7JSONB.sql" "Query8JSONB.sql")
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
            if [ "$print_indexes_applied" = true ]
            then
                echo "Database Indexes have been applied!!!" >> "$current_log_file"
                echo "Repeate query runs after the indexes have been applied: " >> "$current_log_file"
                echo "" >> "$current_log_file"
                
                
            fi
            cat "$current_query_file" >> "$current_log_file"
            echo "" >> "$current_log_file"
        done
        #We do not want the message: 'Database Indexes have been applied' to be printed multiple times
        print_indexes_applied=false
}

#Running queries
function run_queries {
    # initial print of queries to log files
    print_queries "${sql_quries[@]}"

    # run queries based on input counter(how many times it should re-run)
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

    # run queries based on input counter(how many times it should re-run)
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

#Run apply indes which creates indexes
function apply_indexes {
    bash "$apply_indexes_script"
    print_indexes_applied=true
    print_to_execution_log_and_stdout "Indexes have been applied to the Tables."
    print_to_execution_log_and_stdout "The queries will run again:"
}

function remove_indexes {
    bash "$remove_indexes_script"
    print_to_execution_log_and_stdout "Indexes have been removed(cleaned up) from the Tables."
}

#Prints finishing message after the execution of queries is finished
function print_summary_message {
    print_to_execution_log_and_stdout "Running quries finished!"
    print_to_execution_log_and_stdout "For full results please view the log files."
    echo "The execution Log can be viwed at ~/PostgresPerformanceProject/PerformanceTestResults"
}

function print_indexes {
    create_indexes_log_file
    print_to_indexes_log_file_and_stdout "Indexes created: "
    print_to_indexes_log_file_and_stdout ""

    local indexes_information_query=/DatabaseScripts/PerformanceTests/Indexes/GetIndexesInformation.sql
    psql -d "$database" -f "$indexes_information_query" >> "$INDEXES_LOG_FILE"
}
    
#Run main function as the main script flow
function main {
    # default value of query_run_counter is 1 and default value of with_indexes is false.
    local query_run_counter=1
    local with_indexes=false
    local print_indexes_applied=false
    database="CarReservationsDb"
    
    process_input_parameters $@
    define_scripts
    
    local query_results
    local quries
    local sql_quries
    local jsonb_quries

    define_files query_results quries sql_quries jsonb_quries
    create_execution_log_file
    create_test_result_log_files

    print_to_execution_log_and_stdout "Starting execution of queries. This could take a while..."
    run_queries
    
    if [ "$with_indexes" = true ]
    then
        print_to_execution_log_and_stdout "Applying Indexes..."
        print_to_execution_log_and_stdout "Applying indexes and re-running queries again, this could take a while..."
        apply_indexes
        run_queries
        print_indexes
        remove_indexes
    fi

    print_summary_message
}

main $@
