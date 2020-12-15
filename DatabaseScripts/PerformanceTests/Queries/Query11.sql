------------------------------------------------------------
------------------------------------------------------------

-- Query 11
-- Select all from cars table where the brad is 'VW'
-- Standard SQL

EXPLAIN ANALYSE  
SELECT *
FROM "CarReservationsDb"."public"."cars"
WHERE brand = 'VW';