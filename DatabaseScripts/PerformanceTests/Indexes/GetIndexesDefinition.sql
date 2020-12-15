-- Get index definitions
SELECT tablename, indexname, indexdef
FROM pg_indexes
WHERE tablename NOT LIKE 'pg%';