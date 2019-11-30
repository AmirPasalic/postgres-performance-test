#!/bin/bash

cd DatabaseScripts
echo 'Creating the Database...'
psql -f CreateDatabase.sql 
echo 'Database created.'

echo 'Setting up pure SQL Schema.....'
cd Standard
psql -f InitializeSchema.sql
echo 'Initialize Database table schema for: cars, customers and reservations finished.'
psql -f SeedData.sql
echo 'Seeding data finished.'

echo 'Setting up JSONB Schema.....'
cd ../JSONB
psql -f InizializeJsonBSchema.sql
echo 'Create tables with JSONB table schema for: jsonb_cars, jsonb_customers and jsonb_car_reservations finished.'
psql -f SeedJsonBData.sql
echo 'Seeding data finished.'