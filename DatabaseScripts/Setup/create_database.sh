#!/bin/bash

source /Common/default_script_setup.sh
source /Common/constants.sh

#Handle input arguments
function handle_parameters {
        case $1 in 
            -rn | --recordNumber )
                #if argument $2 does not have value or is not a number
                if [ -z "${2+x}" ] || ! [[ $2 =~ $IS_NUMBER_REG_EXP ]] ; then
                    echo ERROR: When using -rn or --recordNumber you need to specify a number as second parameter.
                    exit 1
                fi
                number_of_records=$2;;
            *)
                echo ERROR: Input arguments are not supported.
                exit 1;;                     
        esac
}

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ] && [ "$#" -ne 2 ]; then
        echo ERROR: number of option parameters is not correct.
        exit 1
    fi

    if [ "$#" -eq 2 ] 
    then
        handle_parameters $1 $2
    fi
}

function define_scripts {
    performance_test_script_path="/DatabaseScripts/PerformanceTests"
    readonly INSERT_TEXT_SEPARATOR_SCRIPT="$performance_test_script_path/insert_text_separator.sh"
}

function create_database {
    echo 'Creating the Database...'
    psql -f /DatabaseScripts/Setup/CreateDatabase.sql
    echo 'Database created.'
}

function create_and_seed_sql_schema {
    echo "Setting up pure SQL Schema....."
    psql -f /DatabaseScripts/Setup/Standard/InitializeSchema.sql
    echo "Initialize Database table schema for: cars, customers and reservations finished."
    
    # Create function
    echo "Creating seed_data function..."
    psql -d "$database" -f /DatabaseScripts/Setup/Standard/SeedData.sql
    
    # Call seed_data function
    echo "Seeding data..."
    psql -d "$database" -c "SELECT seed_data($number_of_records)" -f /DatabaseScripts/Setup/Standard/SeedData.sql

    echo "Seeding SQL schema data finished."
}

function create_and_seed_jsonb_schema {
    echo "Setting up JSONB Schema....."
    psql -d "$database" -f /DatabaseScripts/Setup/JSONB/InizializeJsonBSchema.sql
    echo "Create tables with JSONB table schema for: jsonb_cars, jsonb_customers and jsonb_car_reservations finished."
    psql -d "$database" -f /DatabaseScripts/Setup/JSONB/SeedJsonBData.sql
    echo "Seeding JSONB schema data finished."
}

# Creates summary log file where infromation about created tables can be viewed
function create_summary_log_file {
    mkdir -p /DatabaseScripts/SetupSummary/
    local summary_log_file="/DatabaseScripts/SetupSummary/CarReservationsDbSetupSummary.txt"
    touch $summary_log_file
    truncate -s 0 $summary_log_file 

    customersCount=$number_of_records
    let carsCount=$number_of_records*3
    let carReservationsCount=carsCount*4

    echo "Database Information:" >> $summary_log_file
    echo "Database Name: '$database'" >> $summary_log_file
    echo "" >> $summary_log_file

    bash "$INSERT_TEXT_SEPARATOR_SCRIPT" "$summary_log_file"
    echo "Table Information: '$database' database contains following tables: " >> $summary_log_file
    echo "" >> $summary_log_file
    psql -c "\dt" -d "$database" >> $summary_log_file
    echo "" >> $summary_log_file

    bash "$INSERT_TEXT_SEPARATOR_SCRIPT" "$summary_log_file"
    echo "Rows inserted per table:" >> $summary_log_file
    echo "" >> $summary_log_file
    echo "cars: $carsCount" >> $summary_log_file
    echo "customers: $customersCount" >> $summary_log_file
    echo "car_reservations: $carReservationsCount" >> $summary_log_file
    echo "jsonb_cars: $carsCount" >> $summary_log_file
    echo "jsonb_customers: $customersCount" >> $summary_log_file
    echo "jsonb_car_reservations: $carReservationsCount" >> $summary_log_file
    echo "" >> $summary_log_file

    bash "$INSERT_TEXT_SEPARATOR_SCRIPT" "$summary_log_file"
    echo "Details:" >> $summary_log_file
    echo "" >> $summary_log_file
    echo "" >> $summary_log_file
    psql -c "\d+ cars" -d "$database" >> $summary_log_file
    echo "" >> $summary_log_file
    psql -c "\d+ customers" -d "$database" >> $summary_log_file
    echo "" >> $summary_log_file
    psql -c "\d+ car_reservations" -d "$database" >> $summary_log_file
    echo "" >> $summary_log_file
    psql -c "\d+ jsonb_cars" -d "$database" >> $summary_log_file
    echo "" >> $summary_log_file
    psql -c "\d+ jsonb_customers" -d "$database" >> $summary_log_file
    echo "" >> $summary_log_file
    psql -c "\d+ jsonb_car_reservations" -d "$database" >> $summary_log_file
    echo "" >> $summary_log_file
}

#Run main function as the main script flow
function main {
    local number_of_records=1000
    process_input_parameters $@
    database="CarReservationsDb"
    define_scripts
    create_database
    create_and_seed_sql_schema
    create_and_seed_jsonb_schema
    create_summary_log_file
    echo "The execution Summary Log file can be viwed at: ~/PostgresPerformanceProject/DatabaseSetup"
}

main $@