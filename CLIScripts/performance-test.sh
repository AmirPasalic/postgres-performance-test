#!/bin/bash

#Exit when any command fails
set -e

#Show help for the command and how to use it
function help {
    echo "performance-test.sh help command"
}

#Handle input arguments for the script
function handle_arguments {
        case $1 in 
            -h | --help )
                help
                exit 0;;
            *)
                queryRunCounter=1
                withIndexes="";;                     
        esac
}

#Run main function as the main script flow
function main {
    handle_arguments "$@"

    # run queries on schemas
    docker exec -it postgres-db bash ./DatabaseScripts/PerformanceTests/RunPerformanceTest.sh "$@"

    # save performance test results to host machine
    docker exec -it postgres-db cat "/DatabaseScripts/PerformanceTestResults/PerformanceTestLog.txt" > ~/PerformanceTestResults/PerformanceTestLog.txt
}

main "$@"
