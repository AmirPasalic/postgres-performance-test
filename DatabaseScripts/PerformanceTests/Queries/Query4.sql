------------------------------------------------------------
------------------------------------------------------------

-- Query 4
-- Select all cars where a Reservation exists
-- Standard SQL

EXPLAIN ANALYSE  
SELECT *
FROM cars 
INNER JOIN car_reservations AS cr on cars.id = cr.car_id;
