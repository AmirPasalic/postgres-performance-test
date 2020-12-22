# Lab 3 - Run with 100 000 records

## Lab summary
The goal of this lab is to setup the db with 100 000x(hundred thousand factor) entries and run the test queries
3 times on the database with Indexes included. The queries will first run without indexes 
3 times and then after indexes are applied again 3 times. This way you will be able to analyze the results
and compare query performance with and without usage of indexes and to see if by running same query
multiple times the results will be affected. As the data on which we run the tests(queries) increases the 
results should be affected.

## Lab commands
Run the commands in following order:

- `ppt_cleanup` to cleanup the env from previous run 
- `ppt_initialize -rn 100000` to initialize the env and the database: 
- `ppt_performance_test -counter 3 -withIndex`
- `ppt_open_test_results` to open and see the test results
- view the Log files opened in the Directory/Files explorer

# Lab results observations
Conclusion after reviewing Log files of the query test runs:

- Executing the queries without indexes in most cases(for these examples) is slower then 
with indexes applied. The only exception to this are queries which contain JOINS between 2 and 
more tables.

- Seems that executing the same queries multiple times does not affect the speed 
of execution time tremendously. The differences are very small.

- Number of records or recordNumber of 100 000 does affect the execution time on the
tables which have JSONB/Document schema much more then the tables with standard SQL schema.
This is especially the case when indexes are not used.

- The biggest difference in execution time speed is as for all labs the queries which use '=' operator
on the JSONB first level field when an 'BTree Expression Index' is applied like the index
jsonb_cars_brand_index. In this case the JSONB query is x10 times faster then the standard SQL query
altogh they both have BTree indexes on the same filed. Seems like the BTree expression index on JSONB
column is much faster then the standard BTree index on standard SQL column. This gets event 
more significant boost with the index as the number of data increases.
