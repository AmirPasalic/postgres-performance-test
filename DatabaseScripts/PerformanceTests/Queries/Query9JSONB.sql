------------------------------------------------------------
------------------------------------------------------------

-- Query 9
-- Select all from Cars table where the model is 'X1'
-- or model is X3 or model is X5 and car is not used(is_used = false)
-- JSONB

EXPLAIN ANALYSE  
SELECT *
FROM jsonb_cars
WHERE 
	((data -> 'model')::VARCHAR = 'X1' OR
	(data -> 'model')::VARCHAR = 'X3' OR
	(data -> 'model')::VARCHAR = 'X5') 
		AND 
	(((data -> 'is_used')::BOOLEAN)) = false;