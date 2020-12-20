#!/usr/bin/env bash

#Define constants used in this script
function define_constants {
    readonly SCRIPT_DIRRECTORY_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    readonly PROJECT_MAIN_DIR_PATH="$(dirname "$SCRIPT_DIRRECTORY_PATH")"
    readonly HOME_USER_PATH="$(eval echo ~$USER)"
    readonly FILES_PATH="$HOME_USER_PATH/PostgresPerformanceProject/PerformanceTestResults"
    source "$PROJECT_MAIN_DIR_PATH/Common/constants.sh"
    source "$PROJECT_MAIN_DIR_PATH/Common/default_script_setup.sh"
}

#Show help for the command
function help {
    echo ""
    echo "NAME"
    echo "$TAB ppt_open_test_results"
    echo ""
    echo "DESCRIPTION"
    echo "$TAB ppt_open_test_results help page"
    echo "$TAB This command creates a opens the test or execution results from performance-test.sh"
    echo "$TAB For this command to work properly the ppt_performance-test has to be execute before this."
    echo "$TAB Otherwise there will be no execution log files to show."
    echo ""
    echo "$TAB Options:"
    echo ""
    echo "$TAB -h, --help"
    echo "$DOUBLE_TAB Will open the help page for open_test_results.sh help page"
    echo ""
}

#Handle input parameters
function handle_parameters {
    parameter1=${1-default}
    case $parameter1 in 
        -h | --help )
            help
            exit 0;;
        *)
            echo ERROR: Input parameters are not supported.
            exit 1;;                     
    esac
}

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ] && [ "$#" -ne 1 ]; then
        echo ERROR: number of option parameters is not correct.
        exit 1
    fi

    if [ "$#" -eq 1 ] 
    then
        handle_parameters $1
    fi
}

#Run main function as the main script flow
function main {
    define_constants
    process_input_parameters $@
    
    echo "Performance Tests result log files are in: $FILES_PATH"
    echo "Openning the directory..."
    xdg-open "$FILES_PATH"
}

main $@
