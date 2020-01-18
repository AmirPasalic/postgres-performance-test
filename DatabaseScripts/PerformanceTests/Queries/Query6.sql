------------------------------------------------------------
------------------------------------------------------------

-- Query 6
-- Select all car_reservatins with customer and car information 
-- which have car_reservations between tomorrow and next 7 days. 
-- The first_name of the customer should be equal to 'Max' and 
-- the customer has reserved a car with brand VW and model Touareg.
-- Standard SQL

EXPLAIN ANALYSE
SELECT cr.id AS carReservations_Id, ca.brand, ca.model, cus.first_name, cus.last_name, 
	   cr.start_date AS carReservations_start_date, cr.end_date AS carReservations_end_date
FROM car_reservations AS cr
INNER JOIN cars AS ca ON cr.car_id = ca.id
INNER JOIN customers AS cus ON cr.customer_id = cus.id
WHERE 
    (cr.start_date BETWEEN 
            (SELECT 'tomorrow'::DATE tomorrow) 
                AND	
            (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE) 
    ) AND
    ca.brand = 'VW' AND 
    ca.model = 'Touareg' AND
    cus.first_name = 'Max';
