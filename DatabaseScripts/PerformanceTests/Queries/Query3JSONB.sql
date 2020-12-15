------------------------------------------------------------
------------------------------------------------------------

-- Query 3
-- Select all cars where brand is BMW and model is 120d.
-- Get only first 20 records.
-- JSONB

EXPLAIN ANALYSE
SELECT * 
FROM jsonb_cars
WHERE (data -> 'brand')::VARCHAR = 'BMW' AND
      (data -> 'model')::VARCHAR = '120d'
FETCH FIRST 20 ROWS ONLY;
