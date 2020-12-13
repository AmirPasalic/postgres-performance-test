------------------------------------------------------------
------------------------------------------------------------

-- Query 10
-- Select all car_reservatins with customer and car information 
-- which have car_reservations between tomorrow and 7 days in the future.
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