------------------------------------------------------------
------------------------------------------------------------

-- Query 10
-- Select first 200 rows of car_reservatins with which have 
-- car_reservations between tomorrow and 7 days in the future
-- and only car_reservations which are not marked as deleted. 
-- Standard SQL

EXPLAIN ANALYSE
SELECT *
FROM car_reservations AS cr
WHERE cr.start_date BETWEEN 
        (SELECT 'tomorrow'::DATE tomorrow) 
            AND	
        (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE) 
        AND 
        cr.is_deleted = false
FETCH FIRST 200 ROWS ONLY;
    