------------------------------------------------------------
------------------------------------------------------------

-- Example 2.
-- Select all from Cars table where the model is 'X1'
-- or model is X3 or model is X5.
-- JSONB

EXPLAIN ANALYSE  
SELECT *
FROM jsonb_cars
WHERE 
	(data ->> 'model')::VARCHAR AS model = 'X1' OR
	(data ->> 'model')::VARCHAR AS model = 'X3' OR
	(data ->> 'model')::VARCHAR AS model = 'X5';