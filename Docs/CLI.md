## CLI

## CLI Introduction
This project has its own CLI which helps in automating task like: setup db, run performance test, 
open test results, cleanup db and env and so on. This helps the user of this project to setup, 
cleanup(remove database with data), run performance tests in an automated way and as many times
as needed without any additional effort. The CLI is supposed to be used to fully run and 
test the queries and the impact.

## ppt CLI
The ppt CLI (Postgres Performance test Command line interface) is just a name for the CLI used 
for this project.

### CLI Commands

The following commands exist in the project:

- ppt_help
- ppt_initialize
- ppt_cleanup
- ppt_open_test_results
- ppt_performance_test 
- ppt_start_db
- ppt_stop_db.sh

Each command has an help page with some information about the command like how it can be 
used and arguments which can be passed to it. The help page for each command can be viewed by typing for 
example: `ppt_initialize --help or ppt_initialize -h`

#### Help

The ppt_help command will display the help page of the ppt CLI. In the help page there will be a small
summary about all available commands in the ppt CLI.

#### Initialize

The ppt_initialize command will: 
- create a docker container for PostgreSQL. In this PostgreSQL container a test database will be created 
    called CarReservationsDb. The schema for this database will be created with tables structured with standard sql schema and JSONB based schema. 3 tables per schema type will be created.

- seed some test data to this tables

The ppt_initialize command can be run with some input arguments in order to control how many records of the seeded data
should be inserted. This gives the possibility to run the performance test on 1000 entries/rows, 100000, 1 000 000 000 or any number of records in particular tables.

More infos on this command can be found in the help page of the initialize.

Example: `ppt_initialize --help or ppt_initialize -h`

#### Cleanup

The ppt_cleanup script will remove the docker container where the test database "CarReservationsDb" was created.
This means that the database will be removed with all its data.

More info's on this command can be found in the help page of the ppt_cleanup.

Example: `ppt_cleanup --help or ppt_cleanup -h`

#### Open test results

The ppt_open_test_results command is usually useful to be run after the ppt_performance_test command. The 
ppt_open_test_results command will open the location(using default files/directory explorer) of the log files where the test results are saved. This command is like a nice shortcut to save some time to view the result log files. These files
are stored in your home directory in ~/PostgresPerformanceProject/PerformanceTestResults.

More info's on this command can be found in the help page of the ppt_open_test_results.

Example: `ppt_open_test_results --help or ppt_open_test_results -h`

#### Performance test

The ppt_performance_test script will run a set of queries on the CarReservationsDb. Prerequisite is that
we have created the CarReservationsDb with the ppt_initialize command.

Performance test can be run with arguments like how many times the queries should be run and should the queries run
also with applied indexes on the database.

More info's on this command can be found in the help page of the ppt_performance_test

Example: `ppt_performance_test --help or ppt_performance_test -h`

#### Start Db

The ppt_start_db command will start the docker container which hosts the CarReservationsDb which was created with the ppt_initialize command.

More info's on this command can be found in the help page of the ppt_start_db.

Example: `ppt_start_db --help or ppt_start_db -h`

#### Stop Db

The ppt_stop_db command will stop the docker container which hosts the CarReservationsDb which was created with the ppt_initialize command. In order to start it again you can use the ppt_start_db command.

More info's on this command can be found in the help page of the ppt_stop_db

Example: `ppt_stop_db --help or ppt_stop_db -h`
