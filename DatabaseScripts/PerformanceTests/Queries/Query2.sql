------------------------------------------------------------
------------------------------------------------------------

-- Example 2.
-- Select all from Cars table where the model is 'X1'
-- or model is X3 or model is X5.

-- Standard SQL

EXPLAIN ANALYSE  
SELECT *
FROM cars
WHERE model = 'X1' OR model = 'X3' OR model = 'X5';
