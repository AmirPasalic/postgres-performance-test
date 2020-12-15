-- Update statistics
ANALYZE;

-- Get table statistics
SELECT 
  nspname AS sch_name, relname AS table_name, reltuples AS number_of_rows
FROM pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
WHERE 
  nspname NOT IN ('pg_catalog', 'information_schema') AND
  relkind='r' 
ORDER BY reltuples DESC;