#!/bin/bash

source ../Common/constants.sh
source ../Common/default_script_setup.sh

#Show help for the command
function help {
    echo ""
    echo "NAME"
    echo "$TAB stop-db.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$TAB stop-db.sh command page"
    echo "$TAB This command stops the Postgresql docker container where CarReservationsDb database is running."    
    echo ""
    echo "$TAB You can start the Postgresql docker container where CarReservationsDb is running with the start_db.sh command"
    echo "$TAB More infos on that you can find by visiting the help page of the start_db.sh."
    echo "$TAB Example: start_db.sh --help or start_db.sh -h"
    echo "$TAB Also check the initialize.sh command by running the help page of the initialize.sh"
    echo "$TAB Example: initialize.sh --help or initialize.sh -h"
    echo ""
}

#Handle input arguments for the script
function handle_arguments {
        # passed argument or if not set "default"
        argument1=${1-default}
        case $argument1 in
            -h | --help )
                help
                exit 0;;
            *)
                echo ERROR: Input argument not supported.
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
        handle_arguments $1
    fi
}

#Run main function as the main script flow
function main {
    process_input_parameters $@
    #Stop containers
    docker-compose -f "../docker-compose-postgres.yml" stop
}

main $@
