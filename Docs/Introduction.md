# Introduction

## Project
The goal of the project is to test how using a Document based(JSONB) schema affects query performance when
compared to standard SQL schema. For this performance test we have some test queries written for
a test database.

## Test Database
The test database is called "CarReservationsDb". It is a very simplistic database and table design
for the purpose to run some test queries. 
The database contains in total 6 tables. The database contains following tables:
- cars
- customers
- car_reservations
- jsonb_cars
- jsonb_customers
- jsonb_car_reservations

The tables cars, customers anc car_reservation are standard tables with each db column per field. The tables
with the prefix name jsonb_* are tables which contain the same fileds as the ones without the jsonb_* but
thy contain only 2 fileds: id and data(JSONB filed containing all the fileds of the table).

Here are some table examples:
\
\
**Table: cars**

Columns | id | brand | model | company_name | is_used 
--- | --- | --- | --- |--- |--- |---
... | 1 | BMW | X1 | Bayerische Motoren Werke AG | true
... | 2 | VW | Passat | Volkswagen AG | true
... | 3 | Mercedes-Benz | GLE | Daimler AG | true
... | ... | ... | ... | ... | ...
\
\
**Table: jsonb_cars**

Columns | id | datas
--- | --- | --- | --- 
... | 1 | { "brand": "BMW", "model": "X1", "is_used": true, "company_name": "Bayerische Motoren Werke AG"}
... | 2 | { "brand": "VW", "model": "Passat", "is_used": true, "company_name": "Volkswagen AG"} 
... | 3 | { "brand": "Mercedes-Benz", "model": "GLE", "is_used": true, "company_name": "Daimler AG"} 
... | ... | ... | ...
\
As you can see from the example the data which is stored in the cars and jsonb_cars is the same. It is
just stored in a different way. For all the other tables the same pattern is used. 
The queries which will be run on the performance test will be aiming to get the same data.

## Model
The table mode is supposed to represent a small car reservations schema. The car_reservations table
holds the information which cusomer did a car reservation, for which car, for which period is the reservation
and at which time it was created. For this model we have 3 tables: cars, customers and car_reservations.

## Disclaimer
In order to see the Disclaimer for the test data please view section [Disclaimer](../Disclaimer.md)

## Setup the Database and Performance test
In order to understand how the performance_tests is run please read the Docs section for [Setup](Setup.md).

