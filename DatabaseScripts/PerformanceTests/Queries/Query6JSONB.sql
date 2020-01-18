------------------------------------------------------------
------------------------------------------------------------

-- Query 6
-- Select all car_reservatins with customer and car information 
-- which have car_reservations between tomorrow and next 7 days. 
-- The first_name of the customer should be equal to 'Max' and 
-- the customer has reserved a car with brand VW and model Touareg.
-- JSONB

EXPLAIN ANALYSE
SELECT 
  (tmp_jsonb_car_reservations.id)::INTEGER AS car_reservations_id,
  (ca.data ->> 'brand')::VARCHAR AS car_brand, 
  (ca.data ->> 'model')::VARCHAR AS car_model, 
  (cus.data ->> 'first_name'):: VARCHAR AS customer_first_name, 
  (cus.data ->> 'last_name'):: VARCHAR AS customer_last_name,
  (tmp_jsonb_car_reservations.start_date):: DATE AS reservation_start_date,
  (tmp_jsonb_car_reservations.end_date):: DATE AS reservation_end_date
FROM (
  SELECT 
	  id,
	  (data ->> 'car_id')::INTEGER AS car_id,
  	(data ->> 'customer_id')::INTEGER AS customer_id,
	  (data ->> 'start_date')::DATE AS start_date,
	  (data ->> 'end_date')::DATE AS end_date
  FROM jsonb_car_reservations
) tmp_jsonb_car_reservations
INNER JOIN jsonb_cars AS ca
  ON (ca.id = tmp_jsonb_car_reservations.car_id)
INNER JOIN jsonb_customers AS cus
  ON (cus.id = tmp_jsonb_car_reservations.customer_id)
WHERE
    (tmp_jsonb_car_reservations.start_date BETWEEN 
            (SELECT 'tomorrow'::DATE tomorrow) 
                AND	
            (SELECT (SELECT NOW() + INTERVAL '7 DAY')::DATE) 
    ) AND
    ca.data ->> 'brand' = 'VW' AND 
    ca.data ->> 'model' = 'Touareg' AND
    cus.data ->> 'first_name' = 'Max';