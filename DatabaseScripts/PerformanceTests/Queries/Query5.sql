------------------------------------------------------------
------------------------------------------------------------

-- Example 4.
-- Select customer names, cars brand and model and car_reservations start_date 
-- where a car_reservation for that car exists
-- Standard SQL

EXPLAIN ANALYSE  
SELECT cr.id AS car_reservations_id, ca.brand, ca.model, cus.first_name, 
       cus.last_name, cr.start_date AS reservation_start_date
FROM car_reservations AS cr
INNER JOIN cars AS ca ON cr.car_id = ca.id
INNER JOIN customers AS cus ON cr.customer_id = cus.id;