------------------------------------------------------------
------------------------------------------------------------

-- Example 6.
-- Select all Customers which have reservation starting from tomorrow, have first name 'Bill' and have 
-- reserved a brand BMW and model 120d
-- Standard SQL

-- finish this query
EXPLAIN ANALYSE  
SELECT * FROM car_reservations AS cr
INNER JOIN cars AS ca ON cr.car_id = ca.id
INNER JOIN customers AS cus ON cr.customer_id = cus.id
WHERE 
    -- cr.start_date > Now + 5 days in the future
    ca.brand = 'BMW' AND 
    ca.model = '320d' AND
    cus.first_name = 'Bill'


