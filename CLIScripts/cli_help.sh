source ../Common/default_script_setup.sh

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ]; then
        echo ERROR: number of option parameters is not correct.
        exit 1
    fi
}

#ppt (Postgres Performance test) CLI Help
function help {
    #This function should display all the command names an meaning
    echo "ppt_cleanup"
    echo ""
    echo "ppt_initialize"
    echo ""
    echo "ppt_open_test_results"
    echo ""
    echo "ppt_performance_test"
    echo ""
    echo "ppt_start_db" 
    echo ""
    echo "ppt_stop_db" 
    echo ""
    echo "ppt_help" 
}

#Run main function as the main script flow
function main {
    process_input_parameters
    help
}

main $@