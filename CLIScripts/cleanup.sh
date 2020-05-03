#!/bin/bash

source ../Common/constants.sh
source ../Common/default_script_setup.sh

#Show help for the command
function help {
    echo ""
    echo "NAME"
    echo "$TAB cleanup.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$TAB cleanup.sh command page"
    echo "$TAB This command cleans up CarReservationsDb database (deletes the database and all its data)."    
    echo ""
    echo "$TAB You can create the test db database CarReservationsDb by running the initialize.sh command"
    echo "$TAB More infos on that you can find by visiting the help page of the initialize.sh."
    echo "$TAB Example: initialize.sh --help or initialize.sh -h"
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

    if [ "$#" -eq 1 ] 
    then
        handle_parameters $1
    fi
}

#Run main function as the main script flow
function main {
    process_input_parameters $@
    #Cleanup containers
    docker-compose -f "../docker-compose-postgres.yml" down -v
}

main $@
