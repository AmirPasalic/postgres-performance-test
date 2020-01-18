#!/bin/bash

#Exit when any command fails
set -e

#Show help for the command
function help {
    #used as replacement for echo /t has inconsistencies for different terminal clients app emulators
    tab="    " 
    double_tab="        "
    
    echo ""
    echo "NAME"
    echo "$tab start-db.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$tab start-db.sh command page"
    echo "$tab This command starts up the Postgresql docker container where CarReservationsDb database is running."    
    echo ""
    echo "$tab You can stop the Postgresql docker container where CarReservationsDb is running with the stop-db.sh command"
    echo "$tab More infos on that you can find by visiting the help page of the stop-db.sh."
    echo "$tab Example: stop-db.sh --help or stop-db.sh -h"
    echo "$tab Also check the initialize.sh command by running the help page of the initialize.sh"
    echo "$tab Example: initialize.sh --help or initialize.sh -h"
    echo ""
}

#Handle input arguments for the script
function handle_arguments {
        case $1 in 
            -h | --help )
                help
                exit 0;;                 
        esac
}

#Run main function as the main script flow
function main {
    handle_arguments $@
    #Start containers
    docker-compose -f "../docker-compose-postgres.yml" start 
}

main $@
