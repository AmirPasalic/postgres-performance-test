------------------------------------------------------------
------------------------------------------------------------

-- Query 8
-- Select all from cars table where the model is 'X1'
-- or model is X3 or model is X5.
-- JSONB

EXPLAIN ANALYSE  
SELECT *
FROM jsonb_cars
WHERE 
	(data -> 'model')::VARCHAR = 'X1' OR
	(data -> 'model')::VARCHAR = 'X3' OR
	(data -> 'model')::VARCHAR = 'X5';
