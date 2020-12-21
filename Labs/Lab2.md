
# Lab 2 - Run with 10 000 records

## Lab summary
The goal of this lab is to setup the db with 10 000x(ten thousand factor) entries and run the test queries
2 times on the database with Indexes included. The queries will first run without indexes 
2 times and then after indexes are applied again 2 times. This way you will be able to analyze the results
and compare query performance with and without usage of indexes and to see if by running same query
multiple times the results will be affected. On top of this in this Lab we re-reun the same performance test
2 times on the same database. As the data on which we run the tests(queries) increases the 
results should be affected.

## Lab commands

Run the commands in following order:

- `ppt_cleanup` to cleanup the env from previous run 
- `ppt_initialize -rn 10000` to initialize the env and the database: 
- `ppt_performance_test -counter 2 -withIndex`
- `ppt_open_test_results` to open and see the test results
- then rerun the tests on same data again to see if the second run has different results
- `ppt_performance_test -counter 2 -withIndex`
- `ppt_open_test_results` to open and see the test results for each query and other information
regarding tables, indexes and statistics.
- view the Log files opened in the Directory/Files explorer

# Lab results
Conclusion after reviewing Log files of the query test runs:
- note 1
- note 2
- note 3