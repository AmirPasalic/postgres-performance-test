------------------------------------------------------------
------------------------------------------------------------

-- Query 11
-- Select all from cars table where the brand is 'VW'.
-- JSONB

EXPLAIN ANALYZE
SELECT *
FROM jsonb_cars
WHERE (data -> 'brand')::VARCHAR = 'VW';