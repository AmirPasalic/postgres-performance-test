------------------------------------------------------------
------------------------------------------------------------

-- Example 3.
-- Select all Cars where a Reservation exists
-- Standard SQL

EXPLAIN ANALYSE  
SELECT *
FROM cars 
INNER JOIN car_reservations AS cr on car.id = cr.car_id
