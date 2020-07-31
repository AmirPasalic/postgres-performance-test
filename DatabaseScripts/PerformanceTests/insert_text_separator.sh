#!/bin/bash

source /Common/default_script_setup.sh

#Run main function as the main script flow
function main {
    file=$1
    echo '------------------------------------------------------------' >> "$file"
    echo '------------------------------------------------------------' >> "$file"
}

main $@