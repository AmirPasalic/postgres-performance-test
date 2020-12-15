-- Get table and Index sizes(in KB)
SELECT
    relname AS "relation",
    pg_size_pretty (
        pg_total_relation_size (C .oid)
    ) AS "total_relation_size",
    pg_size_pretty (
        pg_relation_size (C .oid)
    ) AS "table_size",
    pg_size_pretty (
        pg_indexes_size (C .oid)
    ) AS "indexes_size"
FROM
    pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C .relnamespace)
WHERE
    nspname NOT IN (
        'pg_catalog',
        'information_schema'
    )
AND C .relkind <> 'i'
AND nspname !~ '^pg_toast'
ORDER BY
    pg_total_relation_size (C .oid) DESC
LIMIT 6;