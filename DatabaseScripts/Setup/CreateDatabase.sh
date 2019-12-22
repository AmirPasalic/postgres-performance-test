#!/bin/bash

#Exit when any command fails
set -e

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
    psql -f SeedData.sql
    echo 'Seeding data finished.'
}

function create_and_seed_jsonb_schema {
    echo 'Setting up JSONB Schema.....'
    cd ../JSONB
    psql -f InizializeJsonBSchema.sql
    echo 'Create tables with JSONB table schema for: jsonb_cars, jsonb_customers and jsonb_car_reservations finished.'
    psql -f SeedJsonBData.sql
    echo 'Seeding data finished.'
}

#Run main function as the main script flow
function main {
    create_database
    create_and_seed_sql_schema
    create_and_seed_jsonb_schema
}

main $@