#!/bin/bash

#Exit when any command fails
set -e

#Handle input arguments
function handle_arguments {
        case $1 in 
            -rn | --recordNumber )
                numberOfRecords=$2;;
            *)
                numberOfRecords=1000;;                     
        esac
}

#Process input parameters for this script
function process_input_parameters {
    if [ "$#" -ne 0 ] && [ "$#" -ne 2 ]; then
        echo ERROR: number of option parameters is not corrext. 1>&2
        exit 1
    fi

    if [ "$#" -eq 0 ] 
    then
        #Default value for number of records is 1000
        numberOfRecords=1000
    fi

    if [ "$#" -eq 2 ] 
    then
        handle_arguments $1 $2
    fi
}

function create_database {
    cd /DatabaseScripts/Setup
    echo 'Creating the Database...'
    psql -f CreateDatabase.sql
    echo 'Database created.'
}

function create_and_seed_sql_schema {
    echo "Setting up pure SQL Schema....."
    cd Standard
    psql -f InitializeSchema.sql
    echo "Initialize Database table schema for: cars, customers and reservations finished."
    
    # Create function
    echo "Creating seed_data function..."
    psql -d "$database" -f SeedData.sql
    
    # call seed_data function
    echo "Seeding data..."
    psql -d "$database" -c "SELECT seed_data($numberOfRecords)" -f SeedData.sql

    echo "Seeding SQL schema data finished."
}

function create_and_seed_jsonb_schema {
    echo "Setting up JSONB Schema....."
    cd ../JSONB
    psql -d "$database" -f InizializeJsonBSchema.sql
    echo "Create tables with JSONB table schema for: jsonb_cars, jsonb_customers and jsonb_car_reservations finished."
    psql -d "$database" -f SeedJsonBData.sql
    echo "Seeding JSONB schema data finished."
}

# Creates summary log file where infromation about created tables can be viewed
function create_summary_log_file {
    cd /DatabaseScripts
    mkdir SetupSummary
    summarylogFile="/DatabaseScripts/SetupSummary/CarReservationsDbSetupSummary.txt"
    touch $summarylogFile
    truncate -s 0 $summarylogFile 

    customersCount=$numberOfRecords
    let carsCount=$numberOfRecords*3
    let carReservationsCount=carsCount*4

    echo "Database Information:" >> $summarylogFile
    echo "Database Name: '$database'" >> $summarylogFile
    echo "" >> $summarylogFile

    echo "Table Information: '$database' database contains following tables: " >> $summarylogFile
    echo "" >> $summarylogFile
    psql -c "\dt" -d "$database" >> $summarylogFile
    
    echo "" >> $summarylogFile
    echo "Rows inserted per table:" >> $summarylogFile
    echo "" >> $summarylogFile
    echo "cars: $carsCount" >> $summarylogFile
    echo "customers: $customersCount" >> $summarylogFile
    echo "car_reservations: $carReservationsCount" >> $summarylogFile
    echo "jsonb_cars: $carsCount" >> $summarylogFile
    echo "jsonb_customers: $customersCount" >> $summarylogFile
    echo "jsonb_car_reservations: $carReservationsCount" >> $summarylogFile
}

#Run main function as the main script flow
function main {
    process_input_parameters $@
    database="CarReservationsDb"
    create_database
    create_and_seed_sql_schema
    create_and_seed_jsonb_schema
    create_summary_log_file
}

main $@