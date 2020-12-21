# Lab 4 - Run with 1 000 000 records

## Lab summary
The goal of this lab is to setup the db with 100 000x(hundred thousand factor) entries and run the test queries
2 times on the database with Indexes included. The queries will first run without indexes 
2 times and then after indexes are applied again 2 times. This way you will be able to analyze the results
and compare query performance with and without usage of indexes and to see if by running same query
multiple times the results will be affected. As the data on which we run the tests(queries) increases the 
results should be affected.

## Lab commands

Run the commands in following order:

- `ppt_cleanup` to cleanup the env from previous run 
- `ppt_initialize -rn 1000000` to initialize the env and the database: 
- `ppt_performance_test -counter 2 -withIndex`
- `ppt_open_test_results` to open and see the test results
- view the Log files opened in the Directory/Files explorer

# Lab results
Summary of observed results.......