------------------------------------------------------------
------------------------------------------------------------

-- Query 10
-- Select all car_reservatins with which have 
-- car_reservations between tomorrow and 7 days in the future. 
-- Standard SQL

EXPLAIN ANALYSE
SELECT *
FROM car_reservations AS cr
WHERE 
    (cr.start_date BETWEEN 
            (SELECT 'tomorrow'::DATE tomorrow) 
                AND	
            (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE) 
    )