# Labs

The Labs serve as a example how you can use and run the code of this project. By looking and trying Labs 
out you can have a breef idea how the CLI commands and this project are supposed to be used. 
The Labs show a way how the CLI are used and how you can run tests runs(the specified queries) to 
view the query results of the and see the performance tests.

**Note:**
The results from the labs can produce different results depending on the host machine where they are running, 
how often they run, usage of resources(CPU and memeory) on the host machine and the time of running.
This means that performance speed and results can be different on different machienes under different
conditions.

## Number of entries x factor
When running the `ppt_initialize` command you can specifiy an argument recordNumber. This means that
you can specify the number of records of test data inserted into tables. To be more prcise the number of records
is not the same for every table it is more like a factor number. For example if the recordNumber is 1000 then
number of entries in the car table is 3 x recordNumber which is 3000. For customer table the number of entries would be 2 x recordNumber which is 2000. For car_reservations table the number of entries would be 12 x recordNumber which is 12000. These number are not so important as they are done to support some
test data and seeding logic for CarReservationsDb. Considering default recordNumber is 1000 and 
if the argument is not specified 1000 factor is going to be used. In this case the tables will have 
following number of records:

- car_reservations 12000
- jsonb_car_reservations 12000
- cars 3000
- jsonb_cars 3000
- customers 2000
- jsonb_customers 2000

If argument recordNumber is for example 10 000 then tables will have following nmumbers of records per
table:

- car_reservations 120000
- jsonb_car_reservations 120000
- cars 30000
- jsonb_cars 30000
- customers 20000
- jsonb_customers 20000

## Labs
Labs:
- [Lab1](Lab1.md) - Run with default 1000 records
- [Lab2](Lab2.md) - Run with 10 000 records
- [Lab3](Lab3.md) - Run with 100 000 records
- [Lab4](Lab4.md) - Run with 1 000 000 records
