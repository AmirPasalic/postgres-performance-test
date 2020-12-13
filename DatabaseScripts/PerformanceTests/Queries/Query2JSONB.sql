------------------------------------------------------------
------------------------------------------------------------

-- Query 2
-- Select all from Cars table where the model is 'X5'
-- and car is used.
-- JSONB

EXPLAIN ANALYZE
SELECT *
FROM jsonb_cars
WHERE 
    (data -> 'model')::VARCHAR = 'X5' 
        AND 
    (((data -> 'is_used')::BOOLEAN)) = true;