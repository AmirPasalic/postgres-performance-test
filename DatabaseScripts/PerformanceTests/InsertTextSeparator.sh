#!/bin/bash

#Exit when any command fails
set -e

#Exit script if an unsed variable is used
set -o nounset

function main {
    file=$1
    echo '------------------------------------------------------------' >> "$file"
    echo '------------------------------------------------------------' >> "$file"
}

main $@