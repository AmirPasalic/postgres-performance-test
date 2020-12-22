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

# Lab results observations
Conclusion after reviewing Log files of the query test runs:

- Executing the queries without indexes in most cases(for these examples) is slower then 
with indexes appied. The only exception to this are queries which contain JOINS between 2 and 
more tables.

- Seems that executing the same queries multiple times does not affect the speed 
of execution time tremendously. The differences are very small.

- Number of records or recordNumber of 1000 is very small so the performance implication can not be
seen compared to the situation where the recordNumber is much higher. Regardless of that the affect and
the differences between Standard SQL and JOSNB/Document queries are visible.

- The biggest difference in execution time speed is as for all labs the queries which use '=' operator
on the JSONB first level field when an 'BTree Expression Index' is applied like the index
jsonb_cars_brand_index. In this case the JSONB query is x10 times faster then the standard SQL query
altogh they both have BTree indexes on the same filed. Seems like the BTree expression index on JSONB
column is much faster then the standard BTree index on standard SQL column.