# Performance tests
Performance test which is executed with the ppt CLI command `ppt_performance_test` is a custom 
designed test particulary designed for this project and the examples used in it. In the project test database
"CarReservationsDb" we have following tables:
- cars
- customers
- car_reservations
- jsonb_cars
- jsonb_customers
- jsonb_car_reservations

As explained in the  [Introduction](Introduction.md) each entity has 2 tables. One table is based on standard SQL schema and another is JSONB/Document based schema. The performance test will run 11 queries for these tables in a way that it will aim to run the same query on both table schemas and compare the results.

## Queries
Each query exists twice. Once it exists for Standard SQL schema table and once for JSONB/Document based schema table. So for example for entity cars we have 2 tables: cars and jsonb_cars with the same data and query on those could be for example:

- Query1.sql

```sql
SELECT *
FROM "CarReservationsDb"."public"."cars"
WHERE model = 'X5';
``` 
- Query1JSONB.sql

```sql
SELECT *
FROM jsonb_cars
WHERE (data -> 'model')::VARCHAR = 'X5';
``` 

## Command

The command to run the performance test is `ppt_performance_test` script will run a set of queries on the CarReservationsDb.

\
To get more information about the CLI command please read the Docs section for [CLI](CLI.md).

## How does it work
When you run the command `ppt_performance_test` it will execute all the queries and create log files with the 
execution results from the Postgresql EXPLAIN ANALYZE command and log it to a log file. The log file would be for example: Query1Log.txt, Query2Log.txt and so on for each query. For example in Query1Log.txt you will see the execution times and the query planner logs for Query1.sql and Query1JSONB.sql. This way you can compare the results in the same file. The same pattern is applied for all queries. 
If you specify the -wi argument like `ppt_performance_test -wi` the queries will be rune once before the indexes
are applied and once after the indexes are applied so you will be able to see the difference in the query performance if they use an index.
If you specify the -c argument the queries will run 'c' number of times like: `ppt_performance_test -c 5`. In
this cae each query will run 5 times. For each query run the results will be logged to the corresponding log file
as described above.

### Results
Apart from the Query1Log.txt..QueryNLog.txt log files we have 2 more general Log files:
- DatabaseInfoLog.txt
Contains additional information about the test database "CarReservationsDb" like:
    - database size
    - indexes definition
    - table and index sizes
    - basic table statistics

- ExecutionLog.txt
ExecutionLog file contains all the steps executed when the command `ppt_performance_test` was running. Here
you can see each step of the performance test.