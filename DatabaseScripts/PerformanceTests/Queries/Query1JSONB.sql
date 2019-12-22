------------------------------------------------------------
------------------------------------------------------------

-- Example 1.
-- Select all from Cars table where the model is 'X5'.
-- JSONB

EXPLAIN ANALYZE
SELECT *
FROM jsonb_cars
WHERE (data ->> 'model')::VARCHAR = 'X5';
