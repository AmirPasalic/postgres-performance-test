------------------------------------------------------------
------------------------------------------------------------

-- Query 1
-- Select all from Cars table where the model is 'X5'.
-- and
-- car is used.
-- Standard SQL

EXPLAIN ANALYSE  
SELECT *
FROM "CarReservationsDb"."public"."cars"
WHERE model = 'X5' AND is_used;
