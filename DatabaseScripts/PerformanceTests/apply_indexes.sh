#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

function apply_index {
    # TBD
    echo "Applying Indexes"
}

#Run main function as the main script flow
function main {
    apply_index
}

main $@