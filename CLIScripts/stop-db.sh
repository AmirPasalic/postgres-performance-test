#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

#Show help for the command
function help {
    #used as replacement for echo /t has inconsistencies for different terminal clients app emulators
    readonly tab="    " 
    readonly double_tab="        "
    
    echo ""
    echo "NAME"
    echo "$tab stop-db.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$tab stop-db.sh command page"
    echo "$tab This command stops the Postgresql docker container where CarReservationsDb database is running."    
    echo ""
    echo "$tab You can start the Postgresql docker container where CarReservationsDb is running with the start-db.sh command"
    echo "$tab More infos on that you can find by visiting the help page of the start-db.sh."
    echo "$tab Example: start-db.sh --help or start-db.sh -h"
    echo "$tab Also check the initialize.sh command by running the help page of the initialize.sh"
    echo "$tab Example: initialize.sh --help or initialize.sh -h"
    echo ""
}

#Handle input arguments for the script
function handle_arguments {
    argument1=${1-default}
    case argument1 in 
        -h | --help )
            help
            exit 0;;                 
    esac
}

#Run main function as the main script flow
function main {
    handle_arguments $@
    #Stop containers
    docker-compose -f "../docker-compose-postgres.yml" stop
}

main $@
