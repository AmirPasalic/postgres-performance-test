SELECT
    t.relname AS table_name,
    i.relname AS index_name,
    a.attname AS column_name
FROM
    pg_class t,
    pg_class i,
    pg_index ix,
    pg_attribute a
WHERE
    t.oid = ix.indrelid
    AND i.oid = ix.indexrelid
    AND a.attrelid = t.oid
    AND a.attnum = ANY(ix.indkey)   
    AND t.relkind = 'r'
AND a.attname != 'id'
AND (t.relname = 'cars' OR 
        t.relname = 'customers' OR 
        t.relname = 'car_reservations' OR
        t.relname = 'jsonb_cars' OR
        t.relname = 'jsonb_customers' OR
        t.relname = 'jsonb_car_reservations')
ORDER BY
    t.relname,
    i.relname;