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
    echo "$tab cleanup.sh"
    echo ""
    echo "DESCRIPTION"
    echo "$tab cleanup.sh command page"
    echo "$tab This command cleans up CarReservationsDb database (deletes the database and all its data)."    
    echo ""
    echo "$tab You can create the test db database CarReservationsDb by running the initialize.sh command"
    echo "$tab More infos on that you can find by visiting the help page of the initialize.sh."
    echo "$tab Example: initialize.sh --help or initialize.sh -h"
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
        esac
}

#Run main function as the main script flow
function main {
    echo 'I AM HERE.'
    handle_arguments $@
    #Cleanup containers
    docker-compose -f "../docker-compose-postgres.yml" down -v
}

main $@
