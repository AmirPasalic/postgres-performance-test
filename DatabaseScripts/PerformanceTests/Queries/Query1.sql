------------------------------------------------------------
------------------------------------------------------------

-- Query 1
-- Select all from Cars table where the model is 'X5'
-- Standard SQL

EXPLAIN ANALYSE  
SELECT *
FROM "CarReservationsDb"."public"."cars"
WHERE model = 'X5';
