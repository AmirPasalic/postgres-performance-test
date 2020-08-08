#!/usr/bin/env bash

set -x;
shopt -s expand_aliases

function main {
    local -r SCRIPT_DIRRECTORY_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
    local -r HOME_USER_DIR="$(eval echo ~$USER)"
    
    bash_aliases="$HOME_USER_DIR/.bash_aliases"
    touch "$bash_aliases"

    cleanup_path="${SCRIPT_DIRRECTORY_PATH}/cleanup.sh"
    initialize_path="${SCRIPT_DIRRECTORY_PATH}/initialize.sh"
    open_test_results_path="${SCRIPT_DIRRECTORY_PATH}/open_test_results.sh"
    performance_test_path="${SCRIPT_DIRRECTORY_PATH}/performance_test.sh"
    start_db_path="${SCRIPT_DIRRECTORY_PATH}/start_db.sh"
    stop_db_path="${SCRIPT_DIRRECTORY_PATH}/stop_db.sh"
    cli_help_path="${SCRIPT_DIRRECTORY_PATH}/cli_help.sh"

    chmod u+x,g+x,a+r "$cleanup_path" 
    chmod u+x,g+x,a+r "$initialize_path"
    chmod u+x,g+x,a+r "$open_test_results_path"
    chmod u+x,g+x,a+r "$performance_test_path"
    chmod u+x,g+x,a+r "$start_db_path"
    chmod u+x,g+x,a+r "$stop_db_path"
    chmod u+x,g+x,a+r "$cli_help_path"

    echo "" >> "$bash_aliases"
    echo "alias ppt_cleanup=${cleanup_path}" >> "$bash_aliases"
    echo "" >> "$bash_aliases"
    echo "alias ppt_initialize=${initialize_path}" >> "$bash_aliases"
    echo "" >> "$bash_aliases"
    echo "alias ppt_open_test_results=${open_test_results_path}" >> "$bash_aliases"
    echo "" >> "$bash_aliases"
    echo "alias ppt_performance_test=${performance_test_path}" >> "$bash_aliases"
    echo "" >> "$bash_aliases"
    echo "alias ppt_start_db=${start_db_path}" >> "$bash_aliases"
    echo "" >> "$bash_aliases"
    echo "alias ppt_stop_db=${stop_db_path}" >> "$bash_aliases"
    echo "" >> "$bash_aliases"
    echo "alias ppt_help=${cli_help_path}" >> "$bash_aliases"

    exec bash
}

main $@
