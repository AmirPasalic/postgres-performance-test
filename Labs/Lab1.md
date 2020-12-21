# Lab 1 - Run with default 1000 records

## Lab summary
The goal of this lab is to setup the db with certin amount of entries. By default
if not specified differently 1000x(factor) entries will be created. The test queries
will run on the database with Indexes included. The queries will first run without indexes 
and then after indexes are applied again. This way you will be able to analyze the results
and compare query performance with and without usage of indexes.
## Lab commands
Run the commands in following order:

- `ppt_cleanup` to cleanup the env from previous run. No need to run this command if no env has been created before. 
- `ppt_initialize` to initialize the env and the database: 
- `ppt_performance_test -withIndex` to run the performance test(queries) with applied indexes.
- `ppt_open_test_results` to open and see the test results for each query and other information
regarding tables, indexes and statistics.
- view the Log files opened in the Directory/Files explorer

# Lab results
Conclusion after reviewing Log files of the query test runs:
- note 1
- note 2
- note 3