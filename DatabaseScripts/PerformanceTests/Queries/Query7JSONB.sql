------------------------------------------------------------
------------------------------------------------------------

-- Query 7
-- Select all car_reservatins with customer information 
-- which has specific customer id. For example the customer.id = 5
-- JSONB

EXPLAIN ANALYSE
SELECT 
  (tmp_jsonb_car_reservations.id)::INTEGER AS car_reservations_id,
  (cus.data ->> 'first_name'):: VARCHAR AS customer_first_name, 
  (cus.data ->> 'last_name'):: VARCHAR AS customer_last_name,
  (tmp_jsonb_car_reservations.start_date):: DATE AS reservation_start_date,
  (tmp_jsonb_car_reservations.end_date):: DATE AS reservation_end_date
FROM (
  SELECT 
	  id,
  	  (data ->> 'customer_id')::INTEGER AS customer_id,
	  (data ->> 'start_date')::DATE AS start_date,
	  (data ->> 'end_date')::DATE AS end_date
  FROM jsonb_car_reservations
) tmp_jsonb_car_reservations
INNER JOIN jsonb_customers AS cus
  ON (cus.id = tmp_jsonb_car_reservations.customer_id)
WHERE cus.id = 5
