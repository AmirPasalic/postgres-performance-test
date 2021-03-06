#!/usr/bin/env bash

#Define constants used in this script
function define_constants {
    readonly SCRIPT_DIRRECTORY_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    readonly PROJECT_MAIN_DIR_PATH="$(dirname "$SCRIPT_DIRRECTORY_PATH")"
    source "$PROJECT_MAIN_DIR_PATH/Common/constants.sh"
    source "$PROJECT_MAIN_DIR_PATH/Common/default_script_setup.sh"
}

#Show help for the command
function help {
    echo ""
    echo "NAME"
    echo "$TAB ppt_cleanup"
    echo ""
    echo "DESCRIPTION"
    echo "$TAB ppt_cleanup command page"
    echo "$TAB This command cleans up CarReservationsDb database (deletes the database and all its data)."    
    echo ""
    echo "$TAB You can create the test db database CarReservationsDb by running the initialize.sh command"
    echo "$TAB More infos on that you can find by visiting the help page of the ppt_initialize command."
    echo "$TAB Example: ppt_initialize --help or ppt_initialize -h"
    echo ""
}

#Handle input parameters for the script
function handle_parameters {
        # passed parameter or if not set "default"
        parameter1=${1-default}
        case $parameter1 in
            -h | --help )
                help
                exit 0;;
            *)
                echo ERROR: Input parameter not supported.
                exit 1;; 
        esac
}

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ] && [ "$#" -ne 1 ]; then
        echo ERROR: number of option parameters is not correct.
        exit 1
    fi

    if [ "$#" -eq 1 ]; then
        handle_parameters $1
    fi
}

#Run main function as the main script flow
function main {
    define_constants
    process_input_parameters $@
    #Cleanup containers
    docker-compose -f "$PROJECT_MAIN_DIR_PATH/docker-compose-postgres.yml" down -v
}

main $@
