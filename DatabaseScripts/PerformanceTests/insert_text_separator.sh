#!/bin/bash

source /Common/default_script_setup.sh

function main {
    file=$1
    echo '------------------------------------------------------------' >> "$file"
    echo '------------------------------------------------------------' >> "$file"
}

main $@