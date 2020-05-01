#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

#Run main function as the main script flow
function main {
    query=$1
    file=$2
    bash "$insertTextSeparatorScript" "$longLog"
}

main $@