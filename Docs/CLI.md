## CLI Introduction
This project has its own CLI which helps in automating task like: setup db, run performance test, 
open test results, cleanup db and env and so on. The CLI is supposed to used to fully run and 
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

Each commands has an help page with some information about the command like how it can be 
used, arguments which can be passed. The help page for each command can be viewed by typing for 
example: `ppt_initialize --help or ppt_initialize -h`

#### Help
TODO...

#### Initialize

The ppt_initialize command will: 
- create a docker container for PostgreSQL. In this PostgreSQL container a test database will be created 
    called CarReservationsDb. The schema for this database will be created with tables structured with standard sql schema and JSONB based schema. 3 tables per schema type will be created.

- seed some test data to this tables

The ppt_initialize command can be run with some input arguments in order to control how many records of the seeded data
should be inserted. This gives the possibility to run the performance test on 1000 or 100000, 1 000 000 000 or any number 
of records in particular tables.

More infos on this command can be found in the help page of the initialize.

Example: `ppt_initialize --help or ppt_initialize -h`

#### Cleanup

The ppt_cleanup script will remove the docker container where the test database "CarReservationsDb" was created.
This means that the database will be removed with all its data.

More info's on this command can be found in the help page of the ppt_cleanup.

Example: `ppt_cleanup --help or ppt_cleanup -h`

#### Open test results
TODO...

#### Performance test

The ppt_performance_test script will run a set of queries on the CarReservationsDb. Prerequisit is of course that
we have created the CarReservationsDb with the ppt_initialize.sh script.

Performance test can be run with some arguments like how many times the queries should be run, should the queries run
also with applied indexes on the database.

More info's on this command can be found in the help page of the ppt_performance_test

Example: `ppt_performance_test --help or ppt_performance_test -h`

#### Start Db

The ppt_start_db script will start the docker container which hosts the CarReservationsDb which was created with the ppt_initialize command.

More info's on this command can be found in the help page of the start_db.sh.

Example: `ppt_start_db --help or ppt_start_db -h`

#### Stop Db

The ppt_stop_db.sh script will stop the docker container which hosts the CarReservationsDb which was created with the ppt_initialize.sh command. In order to start it again you can use the ppt_start_db.sh script.

More info's on this command can be found in the help page of the ppt_stop_db.sh

Example: `ppt_stop_db --help or ppt_stop_db -h`
