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
    echo 'Setting up pure SQL Schema.....'
    cd Standard
    psql -f InitializeSchema.sql
    echo 'Initialize Database table schema for: cars, customers and reservations finished.'
    
    # Create function
    echo 'Creating seed_data function...'
    psql -d "CarReservationsDb" -f SeedData.sql
    
    # call seed_data function
    echo "Seeding data..."
    psql -d "CarReservationsDb" -c "SELECT seed_data($numberOfRecords)" -f SeedData.sql

    echo 'Seeding SQL schema data finished.'
}

function create_and_seed_jsonb_schema {
    echo 'Setting up JSONB Schema.....'
    cd ../JSONB
    psql -f InizializeJsonBSchema.sql
    echo 'Create tables with JSONB table schema for: jsonb_cars, jsonb_customers and jsonb_car_reservations finished.'
    psql -f SeedJsonBData.sql
    echo 'Seeding JSONB schema data finished.'
}

#Run main function as the main script flow
function main {
    process_input_parameters $@
    create_database
    create_and_seed_sql_schema
    create_and_seed_jsonb_schema
}

main $@