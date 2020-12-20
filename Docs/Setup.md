# Setup

## Prerequisites
In order to run this project you need to have:
- OS Linux or OSX
- bash (standard Unix/Linux bash)
- docker
- docker-compose

## First steps
- Clone the repository to your machine
- Setup Project. The project can be used or run from the CLIScripts directory directly but it is much easier 
if you setup the ppt CLI (Postgres Performance test Command line interface). To do this you need to go
the CLIScripts directory in the repository and run: `bash init_setup`

It is important to run this command with your standard user and not with root(without sudo prefix on ubuntu)
- View the ppt CLI help page: `ppt_help`
The `ppt_help` will give you all the information how the CLI can be used.
After this you are ready to use/run the project setup/performance_tests and other commands.

## ppt CLI
The CLI is a set of bash commands which can be used to setup the database, run performance tests, see test results
and so on. You can see all commands in the ppt CLI by running `ppt_help` command in your terminal.
For more information on ppt CLI please read Docs section for [CLI](CLI.md).

## How to run project
In order to setup the database and run the performance tests you need to:

1. Step: run ppt_initialize command which creates test database CarReservationsDb in PostgreSQL docker container.
The ppt_initialize command will create CarReservationsDb and seed test data to it.
After the setup and data seeding of the test database is done you will be able to view the summary of 
the initialization command in form of text log file located at your "home directory" under:
~/PostgresPerformanceProject/DatabaseSetup/CarReservationsDbSetupSummary.txt
This file contains details about the tables and the data.
2. Step: run the ppt_performance_test script in order to execute the queries against the test
database and its tables.
3. Step: The performance test results will be written to multiple log files on your host machine.
The location of the log files is in your home directory: ~/PostgresPerformanceProject/PerformanceTestResults
There you will see: DatabaseInformationLog.txt, ExecutionLog.txt and a Log file for each query like Query1Log.txt.
\

Description of log files: 
- DatabaseInformationLog file contains information like: database size, table and index size and statistics.
- ExecutionLog.txt is the log of the overall execution steps logged to a file.
- Query1Log.txt, Query2Log.txt .. QueryNLog.txt will have information about the query including: the sql code,
execution time without indexes and execution time with indexes applied. Using this you can compare how 
was the execution for standard SQL based query compared to Document based(JSONB) query.

**Note:**
The database and all the performance tests run inside a docker container. Only the summary and performance
log files are copied over to the host machine.

## How to run the commands or scripts?
There are 2 ways how you can run the commands/scripts:
1. By setting up ppt CLI as described above
2. Manually running shell scripts

1. By setting up ppt CLI as described above. If you setup the ppt_ CLI as desicrbed in the section 'First steps' and the `bash init_setup` you are good to go. **This is the preferred way** as you can run
them from any location. You can skip the Option 2.

2. Manually running shell scripts. In order to run the scripts dirctly you need to:
- go to the ./CLIScripts directory
- in the ./CLIScripts directory there are scripts which you can execute in bash terminal

## CLI Information
For more information on ppt CLI (Postgres Performance test Command line interface) please 
read Docs section for [CLI](CLI.md).
