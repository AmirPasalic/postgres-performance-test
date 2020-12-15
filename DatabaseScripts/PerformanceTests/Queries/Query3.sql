------------------------------------------------------------
------------------------------------------------------------

-- Query 3
-- Select all cars where brand is BMW and model is 120d.
-- Get only first 20 records.
-- Standard SQL

EXPLAIN ANALYSE  
SELECT * FROM Cars
WHERE brand = 'BMW' AND model = '120d'
FETCH FIRST 20 ROWS ONLY