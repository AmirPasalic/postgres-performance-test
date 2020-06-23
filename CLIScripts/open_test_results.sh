#!/bin/bash 

source ../Common/constants.sh
source ../Common/default_script_setup.sh

#Show help for the command
function help {
    echo ""
    echo "NAME"
    echo "$TAB open_test_results.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$TAB open_test_results.sh help page"
    echo "$TAB This command creates a opens the test or execution results from performance-test.sh"
    echo "$TAB For this command to work properly the performance-test.sh has to be execute before this."
    echo "$TAB Otherwise there will be no execution log files to show."
    echo ""
    echo "$TAB Options:"
    echo ""
    echo "$TAB -la, --listAll"
    echo "$DOUBLE_TAB Will open all execution log files like: ExecutionLog.txt, Query1Log.txt, Query2Log.txt, Query2Log.txt and" 
    echo "$DOUBLE_TAB other files which where produced by execution of performance-test.sh." 
    echo "$DOUBLE_TAB Example: open_test_results.sh --listAll or open_test_results.sh -ln"
    echo ""
    echo "$TAB -n, --name"
    echo "$DOUBLE_TAB Will open execution log files by name: ExecutionLog.txt, Query1Log.txt, Query2Log.txt, Query2Log.txt and"
    echo "$DOUBLE_TAB Example: open_test_results.sh --name ExecutionLog.txt or open_test_results.sh --n ExecutionLog.txt"
    echo ""
}

#Handle input parameters
function handle_parameters {
        case $1 in 
            -n | --name )
                #if argument $2 does not have value or is not a number
                if [ -z "${2+x}" ] ; then
                    echo ERROR: When using -n or --name you need to specify a file name as second parameter.
                    exit 1
                fi
                file_name=$2;;
            -la | --listAll )
                list_all_files=true;;
            *)
                echo ERROR: Input parameters are not supported.
                exit 1;;                     
        esac
}

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ] && [ "$#" -ne 2 ]; then
        echo ERROR: number of option parameters is not correct.
        exit 1
    fi

    if [ "$#" -eq 2 ] 
    then
        handle_parameters $1 $2
    fi
}

function open_result_files {
    if [ "$file_name" != "" ]
    then
        xdg-open "$file_name"
    fi

    if [ "$list_all_files" = true ]
    then
        file_names=("ExecutionLog.txt" "Query1Log.txt" "Query2Log.txt" "Query3Log.txt" "Query4Log.txt" "Query5Log.txt" "Query6Log.txt" "Query7Log.txt")
        for i in "${!file_names[@]}"
        do
            current_file="$FILES_PATH/${file_names[i]}"
            xdg-open "$current_file"
        done
    fi
}

#Run main function as the main script flow
function main {
    #default values for file:name and list_all_files
    file_name=""
    list_all_files=false
    readonly FILES_PATH="~/PostgresPerformanceProject/PerformanceTestResults/"

    process_input_parameters $@

    #open in the directory explorer
    xdg-open "$FILES_PATH"

    #open in files
    open_result_files
}

main $@
