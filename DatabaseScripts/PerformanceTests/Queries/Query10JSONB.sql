------------------------------------------------------------
------------------------------------------------------------

-- Query 10
-- Select first 200 rows of car_reservatins with customer and car information 
-- which have car_reservations between tomorrow and 7 days in the future
-- and only car_reservations which are not marked as deleted. 
-- JSONB

EXPLAIN ANALYSE
SELECT *
FROM jsonb_car_reservations as cr
WHERE
    ((cr.data ->> 'start_date')::DATE BETWEEN
            (SELECT 'tomorrow'::DATE tomorrow) 
                AND	
            (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE) 
    )
    AND 
    (data -> 'is_deleted')::BOOLEAN = false
FETCH FIRST 200 ROWS ONLY;