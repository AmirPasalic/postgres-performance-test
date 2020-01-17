------------------------------------------------------------
------------------------------------------------------------

-- Example 7.
-- Select all car_reservatins with customer information 
-- which has specific customer id. For example the customer.id = 5
-- Standard SQL

EXPLAIN ANALYSE
SELECT cr.id AS carReservations_Id, cus.first_name, cus.last_name, 
	   cr.start_date AS carReservations_start_date, cr.end_date AS carReservations_end_date
FROM car_reservations AS cr
INNER JOIN customers AS cus ON cr.customer_id = cus.id
WHERE cus.id = 5;