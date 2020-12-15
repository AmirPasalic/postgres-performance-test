------------------------------------------------------------
------------------------------------------------------------

-- Query 9
-- Select all from Cars table where the model is 'X1'
-- or model is X3 or model is X5 and the car is not used(is_used = false)
-- Standard SQL

EXPLAIN ANALYSE  
SELECT *
FROM cars
WHERE 
    (model = 'X1' OR model = 'X3' OR model = 'X5') AND 
    is_used = false;
