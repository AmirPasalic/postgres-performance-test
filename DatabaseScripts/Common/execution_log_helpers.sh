#!/usr/bin/env bash

source /Common/default_script_setup.sh
source /DatabaseScripts/Common/constants.sh

# Create a general log file where execution logs will be logged
function create_execution_log_file {
    mkdir -p "$LOGS_PATH"
    touch "$EXECUTION_LOG_FILE"
    truncate -s 0 "$EXECUTION_LOG_FILE"
    echo "Execution Log for performance test: " >> $EXECUTION_LOG_FILE
    echo "" >> "$EXECUTION_LOG_FILE"
}

# Create a Indexes log file where information about indexes will be logged
function create_indexes_log_file {
    mkdir -p "$LOGS_PATH"
    touch "$INDEXES_LOG_FILE"
    truncate -s 0 "$INDEXES_LOG_FILE"
    echo "Indexes information Logs. " >> $INDEXES_LOG_FILE
    echo "" >> "$INDEXES_LOG_FILE"
}

#Will print given message to ExecutionLog.txt and to stdout of current execution terminal
function print_to_execution_log_and_stdout {
    current_message=$1
    add_timestamp_prefix_to_current_message "$current_message"
    echo "$current_message" >> "$EXECUTION_LOG_FILE"
    echo "$current_message"
}

#Will print given message to IndexesLog file and to stdout of current execution terminal
function print_to_indexes_log_file_and_stdout {
    current_message=$1
    add_timestamp_prefix_to_current_message "$current_message"
    echo "$current_message" >> "$INDEXES_LOG_FILE"
    echo "$current_message"
}

#Add time stamp prefix to message
function add_timestamp_prefix_to_current_message {
    current_message=$1
    if [ "$current_message" != "" ]
    then
        timeStamp=$(date '+%F %T.%3N') #timestamp with miliseconds precision
        current_message="$timeStamp: ${current_message}"
    fi
}