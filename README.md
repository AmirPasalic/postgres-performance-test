# Postgres Performance Test Project

## About the Project

The scope of this project is to setup a simple test database and run some queries to measure their performance.
The goal is to test simple PostgreSQL sql relational table based schema in comparison to JSONB based schema
and how same queries(queries which aim to retrieve same data regardless of table structure) will perform based on the table structures.

## Motivation

The motivation was to test in PostgreSQL db how standard sql schema compares to JSONB based schema. By saying standard schema I mean a standard relational table design with separate column for each filed. On the other hand by saying the JSONB based schema I mean a table design where only the unique identifier of the table is a separate column. Everything else is one JSONB column called data or content which is serving as some kind of payload.

**Why?**

Seeing multiple project going away from standard relational table design for multiple reasons I wanted to test the impact
on some standard or often used queries.

*As always my standard motivation behind this project is as always to learn something and try things out.* 

## Prerequisites

In order to run this project you need to have:
- OS Linux or OSX
- bash (standard Unix/Linux bash)
- docker
- docker-compose

## Running the Project

### How to run project

In order to setup the database and run the performance tests you need to:

1. Step: run initialize.sh script which creates test database CarReservationsDb in PostgreSQL docker container.
The initialize.sh script will create CarReservationsDb and seed test Data to it.
After the setup and data seeding of the test database is done you can view the summary of the initialize.sh script 
in form of text log file at:
~/PostgresPerformanceProject/DatabaseSetup/PerformanceTestLog.txt
2. Step: run the performance-test.sh script in order to execute the queries against the test
database and its tables.
3. Step: The performance test results will be written to text file as output logs on your host machine.
The location of the log file is: ~/PostgresPerformanceProject/PerformanceTestResults/PerformanceTestLog.txt
This log file will contain all the information about the queries including the execution plans, planning 
and execution time.

**Note:**
The database and all the performance tests run inside a docker container. Only the summary and performance
log files are copied over to the host machine.

### How to run the scripts

In order to run this project you need to:
- go to the ./CLIScripts directory
- in the ./CLIScripts directory there are scripts which you can execute in bash terminal

### Scripts

The following scripts exist in the project:

- initialize.sh
- cleanup.sh
- start-db.sh
- stop-db.sh
- performance-test.sh

Each script has an help page with some information about the script, arguments which can be passed.
The help page can be viewed by typing for example: `initialize.sh --help or initialize.sh -h` 

#### Initialize

The initialize.sh script will: 
- create a docker container for PostgreSQL. In this PostgreSQL container a test database will be created 
    called CarReservationsDb. The schema for this database will be created with tables structured with standard sql schema and JSONB based schema. 3 tables per schema type will be created.

- seed some test data to this tables

The initialize.sh script can be run with some input arguments in order to control how many records of the seeded data
should be inserted. This gives the possibility to run the performance test on 1000 or 100000, 1 000 000 000 or any number 
of records in particular tables.

More infos on this command can be found in the help page of the initialize.sh.

Example: `initialize.sh --help or initialize.sh -h`

#### Cleanup

The cleanup.sh script will remove the docker container where the test database "CarReservationsDb" was created.
This means that the database will be removed with all its data.

More info's on this command can be found in the help page of the cleanup.sh.

Example: `cleanup.sh --help or cleanup.sh -h`

#### Start Db

The start-db.sh script will start the docker container which hosts the CarReservationsDb which was created with the initialize.sh command.

More info's on this command can be found in the help page of the start-db.sh.

Example: `start-db.sh --help or start-db.sh -h`

#### Stop Db

The stop-db.sh script will stop the docker container which hosts the CarReservationsDb which was created with the initialize.sh command. In order to start it again you can use the start-db.sh script.

More info's on this command can be found in the help page of the stop-db.sh

Example: `stop-db.sh --help or stop-db.sh -h`


#### Performance test

The performance-test.sh script will run a set of queries on the CarReservationsDb. Prerequisit is of course that
we have created the CarReservationsDb with the initialize.sh script.

Performance test can be run with some arguments like how many times the queries should be run, should the queries run
also with applied indexes on the database.

More info's on this command can be found in the help page of the performance-test.sh

Example: `performance-test.sh --help or performance-test.sh -h`


## License

TBD.

