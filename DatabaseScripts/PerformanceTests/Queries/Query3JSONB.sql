------------------------------------------------------------
------------------------------------------------------------

-- Query 3
-- Select all Cars where brand is BMW and model is 120d
-- JSONB

EXPLAIN ANALYSE
SELECT * 
FROM jsonb_cars
WHERE data ->>'brand' = 'BMW' AND
      data ->> 'model' = '120d';
