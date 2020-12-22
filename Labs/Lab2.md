# Lab 2 - Run with 10 000 records

## Lab summary
The goal of this lab is to setup the db with 10 000x(ten thousand factor) entries and run the test queries
2 times on the database with Indexes included. The queries will first run without indexes 
2 times and then after indexes are applied again 2 times. This way you will be able to analyze the results
and compare query performance with and without usage of indexes and to see if by running same query
multiple times the results will be affected. On top of this in this Lab we rerun the same performance test
2 times on the same database. As the data on which we run the tests(queries) increases the 
results should be affected.

## Lab commands

Run the commands in following order:

- `ppt_cleanup` to cleanup the env from previous run 
- `ppt_initialize -rn 10000` to initialize the env and the database: 
- `ppt_performance_test -counter 2 -withIndex`
- `ppt_open_test_results` to open and see the test results
- view the Log files opened in the Directory/Files explorer
- then rerun the tests on same data again to see if the second run has different results
- `ppt_performance_test -counter 2 -withIndex`
- `ppt_open_test_results` to open and see the test results for each query and other information
regarding tables, indexes and statistics.
- view the Log files opened in the Directory/Files explorer

# Lab results observations
Conclusion after reviewing Log files of the query test runs:

- Executing the queries without indexes in most cases(for these examples) is slower then 
with indexes applied. The only exception to this are queries which contain JOINS between 2 and 
more tables.

- Seems that executing the same queries multiple times does not affect the speed 
of execution time tremendously. The differences are very small.

- Running the performance_test command multiple times does not affect the execution time.
The results are very similar regardless of how many times you run the test.

- Number of records or recordNumber of 10 000 does affect the execution time on the
tables which have JSONB/Document schema more then the tables with standard SQL schema.

- The biggest difference in execution time speed is as for all labs the queries which use '=' operator
on the JSONB first level field when an 'BTree Expression Index' is applied like the index
jsonb_cars_brand_index. In this case the JSONB query is x10 times faster then the standard SQL query
although they both have BTree indexes on the same filed. Seems like the BTree expression index on JSONB
column is much faster then the standard BTree index on standard SQL column. This gets event 
more significant boost with the index as the number of data increases.
